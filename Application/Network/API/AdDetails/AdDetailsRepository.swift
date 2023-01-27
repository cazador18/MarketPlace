import Foundation

public protocol AdDetailsRepositoryProtocol {
    func getAdDetails(uuid: String, completionHandler: @escaping (Result<AdDetails, NetworkError>) -> Void)
}
public class AdDetailsRepository: BaseRepository, AdDetailsRepositoryProtocol {
    let accessTokenProvider: AccessTokenProviderProtocol
    
    init(service: NetworkService, accessTokenProvider: AccessTokenProviderProtocol) {
        self.accessTokenProvider = accessTokenProvider
        super.init(service: service)
    }
    
    public func getAdDetails(uuid: String, completionHandler: @escaping(Result<AdDetails, NetworkError>) -> Void) {
        let request = AdDetailsAPIRouter.adDetails(uuid: uuid).createURLRequest()
        makeRequest(ofType: ResultResponse<AdDetails>.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider) { result in
            switch result {
            case .success(let result):
                if let model = result.result {
                    completionHandler(.success(model))
                } else {
                    completionHandler(.failure(.emptyResponse))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
