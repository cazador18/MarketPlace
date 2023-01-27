import Foundation
import ObjectMapper

internal protocol FAQRepositoryProtocol {
    func getFAQResult(completion: @escaping(Result<FAQResult, NetworkError>) -> Void)
}

internal final class FAQRepository: BaseRepository, FAQRepositoryProtocol {

    let accessTokenProvider: AccessTokenProviderProtocol

    init(service: NetworkService, accessTokenProvider: AccessTokenProviderProtocol) {
        self.accessTokenProvider = accessTokenProvider
        super.init(service: service)
    }
    
    func getFAQResult(completion: @escaping (Result<FAQResult, NetworkError>) -> Void) {
        let request = FAQAPIRouter.getFAQ.createURLRequest()
        makeRequest(ofType: FAQResult.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider,
                    completion: completion)
    }
}
