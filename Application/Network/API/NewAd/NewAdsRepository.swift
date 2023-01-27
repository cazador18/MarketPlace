import Foundation
public protocol NewAdsRepositiryProtocol {
    func newAdUUID(completionHandler: @escaping (Result<NewAdsResponse, NetworkError>) -> Void)
    func putBodyInAd(adUUID: String, model: NewAdBodyModel, completionHandler: @escaping (Result<NewAdsResponse, NetworkError>) -> Void)
    func postImageInAd(adUUID: String, image: Data, completionHandler: @escaping (Result<NewAdsImageResponse, NetworkError>) -> Void)
}
public class NewAdsRepository: BaseRepository, NewAdsRepositiryProtocol {
    
    public let accessTokenProvider: AccessTokenProviderProtocol
    
    public init(service: NetworkService, accessTokenProvider: AccessTokenProviderProtocol) {
        self.accessTokenProvider = accessTokenProvider
        super.init(service: service)
    }
    
    public func newAdUUID(completionHandler: @escaping (Result<NewAdsResponse, NetworkError>) -> Void) {
        let request = NewAdsApiRouter.createUUID.createURLRequest()
        makeRequest(ofType: NewAdsResponse.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider,
                    completion: completionHandler)
    }
    
    public func putBodyInAd(adUUID: String, model: NewAdBodyModel, completionHandler: @escaping (Result<NewAdsResponse, NetworkError>) -> Void) {
        let request = NewAdsApiRouter.addBodyToAd(adUUID: adUUID, body: model).createURLRequest()
        makeRequest(ofType: NewAdsResponse.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider,
                    completion: completionHandler)
    }
    
    public func postImageInAd(adUUID: String, image: Data, completionHandler: @escaping (Result<NewAdsImageResponse, NetworkError>) -> Void) {
        let request = NewAdsApiRouter.addImageToAd(adUUID: adUUID).createUploadImageRequest(image: image)
        makeRequest(ofType: NewAdsImageResponse.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider,
                    completion: completionHandler)
    }
}
