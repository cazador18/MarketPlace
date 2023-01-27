import Foundation
import ObjectMapper

internal protocol MainRepositoryProtocol {
    func getAdsList(page: String?, complitionHandler: @escaping (Result<AdResult, NetworkError>) -> Void)
    func getCategoryList(complitionHandler: @escaping (Result<ResultCategory, NetworkError>) -> Void)
    func getFilteredList(page: String?,
                         categoryId: Int,
                         complitionHandler: @escaping (Result<AdResult, NetworkError>) -> Void)
    func getFilteredList(page: String?,
                         text: String,
                         category: Int?,
                         complitionHandler: @escaping (Result<AdResult, NetworkError>) -> Void)
}

internal final class MainRepository: BaseRepository, MainRepositoryProtocol {
    private let accessTokenProvider: AccessTokenProviderProtocol
    
    internal init(service: NetworkService, accessTokenProvider: AccessTokenProviderProtocol) {
        self.accessTokenProvider = accessTokenProvider
        super.init(service: service)
    }
    
    internal func getAdsList(page: String?,
                             complitionHandler: @escaping (Result<AdResult, NetworkError>) -> Void) {
        guard let page = page else { return }
        let request = MainAPIRouter.token(page: page).createURLRequest()
        makeRequest(ofType: AdResult.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider,
                    completion: complitionHandler)
    }
    
    internal func getFilteredList(page: String?,
                                  categoryId: Int,
                                  complitionHandler: @escaping (Result<AdResult, NetworkError>) -> Void) {
        guard let page = page else { return }
        let request = FilterAPIRouter.filterCategory(categoryId: categoryId,
                                                     page: page).createURLRequest()
        makeRequest(ofType: AdResult.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider,
                    completion: complitionHandler)
    }
    
    internal func getFilteredList(page: String?,
                                  text: String,
                                  category: Int?,
                                  complitionHandler: @escaping (Result<AdResult, NetworkError>) -> Void) {
        guard let page = page else { return }
        let request = FilterAPIRouter.filterTitle(categoryId: category,
                                                  title: text,
                                                  page: page).createURLRequest()
        makeRequest(ofType: AdResult.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider,
                    completion: complitionHandler)
    }
    
    internal func getCategoryList(complitionHandler: @escaping (Result<ResultCategory, NetworkError>) -> Void) {
        let request = CategoryAPIRouter.token.createURLRequest()
        makeRequest(ofType: ResultCategory.self,
                    request: request,
                    accessTokenProvider: accessTokenProvider,
                    completion: complitionHandler)
    }
}
