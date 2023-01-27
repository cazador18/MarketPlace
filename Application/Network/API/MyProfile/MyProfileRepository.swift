import Foundation

internal protocol MyProfileRepositoryProtocol {
    func getActiveAds(page: String?,
                      completionHandler: @escaping (Result<MyProfileAdResponse, NetworkError>) -> Void)
    
    func getDisabledAds(page: String?,
                        completionHandler: @escaping (Result<MyProfileAdResponse, NetworkError>) -> Void)
}

internal final class MyProfileRepository: BaseRepository, MyProfileRepositoryProtocol {
    internal let accessTokenProvider: AccessTokenProviderProtocol

    internal init(service: NetworkService, accessTokenProvider: AccessTokenProviderProtocol) {
        self.accessTokenProvider = accessTokenProvider
        super.init(service: service)
    }

    internal func getActiveAds(page: String?,
                               completionHandler: @escaping (Result<MyProfileAdResponse, NetworkError>) -> Void) {
        let request = MyProfileAPIRouter.getActiveAds(page: page).createURLRequest()
        makeRequest(ofType: MyProfileAdResponse.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider,
                    completion: completionHandler)
    }
    
    internal func getDisabledAds(page: String?,
                                 completionHandler: @escaping (Result<MyProfileAdResponse, NetworkError>) -> Void) {
        let request = MyProfileAPIRouter.getDisabledAds(page: page).createURLRequest()
        makeRequest(ofType: MyProfileAdResponse.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider,
                    completion: completionHandler)
    }
}
