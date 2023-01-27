import Foundation
public enum FilterAPIRouter: BaseRouter {
    case filterCategory(categoryId: Int, page: String?)
    case filterTitle(categoryId: Int?, title: String, page: String?)
    
    public var host: String {
        switch self {
        default:
            return "staging-api-market.o.kg"
        }
    }
    
    public var path: String {
        switch self {
        default:
            return "/api/ads-board/trusted/ads-filter-old/"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    public var queryParameter: [URLQueryItem]? {
        switch self {
        case .filterCategory(_, let page):
            let queryItem: URLQueryItem = .init(name: "page", value: page)
            return [queryItem]
        case .filterTitle(_, _, let page):
            let queryItem: URLQueryItem = .init(name: "page", value: page)
            return [queryItem]
        }
    }
    
    public var httpBody: Data? {
        switch self {
        case .filterCategory(let categoryId, _):
            let parameters: Parameters = [
                "main_filters": [
                    "category_id": categoryId
                ]
            ]
            let data = try? JSONParameterEncoder().encode(with: parameters)

            return data
            
        case .filterTitle(let categoryId, let title, _):
            let parameters: Parameters = createParameters(id: categoryId,
                                                          title: title)
            let data = try? JSONParameterEncoder().encode(with: parameters)

            return data
        }
    }
    
    public var httpHeaders: HTTPHeaders? {
        switch self {
        default:
            return ["x-api-key": "ypsGjpmpDR9GndA9YvzBHpIqXsFStfyq"]
        }
    }
    
    public var port: Int? {
        switch self {
        default:
            return nil
        }
    }
    
    private func createParameters(id: Int?, title: String) -> Parameters {
        let parameters: Parameters
        if let id = id {
            parameters = [
                "main_filters": [
                    "category_id": id,
                    "q": title
                ]
            ]
        } else {
            parameters = [
                "main_filters": [
                    "q": title
                ]
            ]
        }
        
        return parameters
    }
}
