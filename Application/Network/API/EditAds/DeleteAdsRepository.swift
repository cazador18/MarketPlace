import Foundation

public protocol DeleteAdsRepositoryProtocol {
    func deleteAds(uuid: String, completionHandler: @escaping (Result<DeleteAdsResponse, NetworkError>) -> Void)
}
public class DeleteAdsRepository: BaseRepository, DeleteAdsRepositoryProtocol {
    let accessTokenProvider: AccessTokenProviderProtocol

    init(service: NetworkService, accessTokenProvider: AccessTokenProviderProtocol) {
        self.accessTokenProvider = accessTokenProvider
        super.init(service: service)
    }
    public func deleteAds(uuid: String, completionHandler: @escaping (Result<DeleteAdsResponse, NetworkError>) -> Void) {
        let request = DeleteAPIRouter.deleteAds(uuid: uuid).createURLRequest()
        makeRequest(ofType: DeleteAdsResponse.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider, completion: completionHandler)
    }
}
