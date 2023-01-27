import UIKit

public enum FAQAPIRouter: BaseRouter {
    
    case getFAQ
    
    public var host: String {
        switch self {
        case .getFAQ:
            return "staging-api-market.o.kg"
        }
    }
    
    public var path: String {
        switch self {
        case .getFAQ:
            return "/api/ads-board/faq/"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getFAQ:
            return .get
        }
    }
    
    public var queryParameter: [URLQueryItem]? {
        switch self {
        case .getFAQ:
            return nil
        }
    }
    
    public var httpBody: Data? {
        switch self {
        case .getFAQ:
            return nil
        }
    }
    
    public var httpHeaders: HTTPHeaders? {
        var headers = [String: String]()
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else { return nil }
        headers["Authorization"] = token
        return headers
    }
    
    public var port: Int? {
        switch self {
        case .getFAQ:
            return nil
        }
    }
}
