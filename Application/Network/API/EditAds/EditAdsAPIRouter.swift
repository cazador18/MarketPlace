import Foundation

public enum EditAdsApiRouter: BaseRouter {
    case editAds(uuid: String, model: MyAds)
    case deleteAd(uuid: String)
    case searchCategoryID(name: String)
    
    public var host: String {
        switch self {
        default:
            return "staging-api-market.o.kg"
        }
    }
    
    public var path: String {
        switch self {
        case .editAds(let uuid, _):
            return "/api/ads-board/v1/ads/\(uuid)/"
        case .deleteAd(let uuid):
            return "/api/ads-board/v1/ads/\(uuid)/"
        case .searchCategoryID:
            return "/api/ads-board/v1/protected/category/search-by-word/"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .editAds:
            return .put
        case .deleteAd:
            return .delete
        case .searchCategoryID:
            return .post
        }
    }
    
    public var queryParameter: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
    public var port: Int? {
        switch self {
        default:
            return nil
        }
    }
    
    public var httpBody: Data? {
        switch self {
        case .editAds(_, let model):
            var adBody: Parameters = [
                "title": model.title!,
                "description": model.description!,
                "location": 1
            ]
            
            if let categoryId = model.categoryID {
                adBody["category"] = categoryId
            }
            
            if let adType = model.adType {
                adBody["ad_type"] = adType
            }
            
            if let priceString = model.price,
               let price = Int(priceString),
               price != .zero {
                adBody["price"] = price
            }
            
            if let currency = model.currency {
                adBody["currency"] = currency
            }
            
            if let oMoneyPay = model.oMoneyPay {
                if oMoneyPay {
                    adBody["o_money_pay"] = true
                } else {
                    adBody["o_money_pay"] = false
                }
            }
            
            if let whatsAppPhoneNumber = model.whatsapp {
                adBody["whatsapp_num_is_ident"] = true
                adBody["whatsapp_num"] = whatsAppPhoneNumber
            }
            
            if let telegramUsername = model.telegram {
                adBody["telegram_profile_is_ident"] = true
                adBody["telegram_profile"] = telegramUsername
            }
            
            if let images = model.minifyImages {
                adBody["images"] = images
            }
            
            let data = try? JSONParameterEncoder().encode(with: adBody)
            
            return data
            
        case .searchCategoryID(let name):
            let adBody: Parameters = [
                "q": name
            ]
            
            let data = try? JSONParameterEncoder().encode(with: adBody)
            return data
            
        default:
            return nil
        }
    }
    
    public var httpHeaders: HTTPHeaders? {
        switch self {
        default:
            return ["x-api-key": "ypsGjpmpDR9GndA9YvzBHpIqXsFStfyq"]
        }
    }
}
