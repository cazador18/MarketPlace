import Foundation
import ObjectMapper

open class BaseRepository {
    public let service: NetworkService
    
    public init(service: NetworkService) {
        self.service = service
    }
    
    open func makeRequest<Model: Mappable>(ofType type: Model.Type,
                                           request: URLRequest,
                                           accessTokenProvider: AccessTokenProviderProtocol?,
                                           completion: @escaping (Result<Model, NetworkError>) -> Void) {
        makeRequestAndParseResult(ofType: Model.self,
                                  request: request,
                                  accessTokenProvider: accessTokenProvider) { [weak self] result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                switch error {
                case .unauthorized:
                    self?.refreshToken(
                        accessTokenProvider: accessTokenProvider) { [weak self] error in
                            if let error = error {
                                completion(.failure(error))
                            } else {
                                self?.makeRequestAndParseResult(
                                    ofType: Model.self,
                                    request: request,
                                    accessTokenProvider: accessTokenProvider,
                                    completion: completion)
                            }
                        }
                default:
                    completion(.failure(error))
                }
            }
        }
    }
}

private extension BaseRepository {
    
    func makeRequestAndParseResult<Model: Mappable>(
        ofType type: Model.Type,
        request: URLRequest,
        accessTokenProvider: AccessTokenProviderProtocol?,
        completion: @escaping (Result<Model, NetworkError>) -> Void) { var request = request
            if let accessToken = accessTokenProvider?.token?.accessToken { request.addValue(accessToken,
                                                                                            forHTTPHeaderField: "Authorization") }
            service.getData(with: request) { result in
                switch result {
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8),
                       let model = Model(JSONString: jsonString) {
                        completion(.success(model))
                    } else { completion(.failure(.failedMapping)) }
                case .failure(let error):
                    completion(.failure(error))
                }
            }.resume()
        }
    
    func refreshToken(accessTokenProvider: AccessTokenProviderProtocol?,
                      completion: @escaping (NetworkError?) -> Void) {
        if let refreshToken = accessTokenProvider?.token?.refreshToken {
            let request = RefreshTokenRouter.refreshToken(refreshToken: refreshToken).createURLRequest()
            makeRequestAndParseResult(
                ofType: RefreshTokenResponse.self,
                request: request,
                accessTokenProvider: nil) { result in
                    switch result {
                    case .success(let model):
                        accessTokenProvider?.update(with: model.accessToken)
                        completion(nil)
                    case .failure(let error):
                        completion(error)
                    }
                }
        } else {
            completion(.unauthorized(""))
        }
    }
}
