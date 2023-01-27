import Foundation

internal protocol EditAdsRepositiryProtocol {
    func editAds(uuid: String, model: MyAds, completionHandler: @escaping (Result<NewAdsResponse, NetworkError>) -> Void)
    func searchCategory(name: String, completionHander: @escaping (Result<SearchByWordCategoryResult, NetworkError>) -> Void)
    func deleteAd(uuid: String, completionHandler: @escaping (Result<NewAdsResponse, NetworkError>) -> Void)
    func postImageInAd(adUUID: String, image: Data, completionHandler: @escaping (Result<NewAdsImageResponse, NetworkError>) -> Void)
}
internal class EditAdsRepository: BaseRepository, EditAdsRepositiryProtocol {
 
    internal let accessTokenProvider: AccessTokenProviderProtocol

    internal init(service: NetworkService, accessTokenProvider: AccessTokenProviderProtocol) {
        self.accessTokenProvider = accessTokenProvider
        super.init(service: service)
    }
    
    internal func editAds(uuid: String, model: MyAds, completionHandler: @escaping (Result<NewAdsResponse, NetworkError>) -> Void) {
        let request = EditAdsApiRouter.editAds(uuid: uuid, model: model).createURLRequest()
        makeRequest(ofType: NewAdsResponse.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider,
                    completion: completionHandler)
    }
    
    internal func searchCategory(name: String, completionHander: @escaping (Result<SearchByWordCategoryResult, NetworkError>) -> Void) {
        let request = EditAdsApiRouter.searchCategoryID(name: name).createURLRequest()
        makeRequest(ofType: SearchByWordCategoryResult.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider,
                    completion: completionHander)
    }
    
    internal func deleteAd(uuid: String, completionHandler: @escaping (Result<NewAdsResponse, NetworkError>) -> Void) {
        let request = EditAdsApiRouter.deleteAd(uuid: uuid).createURLRequest()
        makeRequest(ofType: NewAdsResponse.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider,
                    completion: completionHandler)
    }
    
    internal func postImageInAd(adUUID: String, image: Data, completionHandler: @escaping (Result<NewAdsImageResponse, NetworkError>) -> Void) {
        let request = NewAdsApiRouter.addImageToAd(adUUID: adUUID).createUploadImageRequest(image: image)
        makeRequest(ofType: NewAdsImageResponse.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider,
                    completion: completionHandler)
    }
}
