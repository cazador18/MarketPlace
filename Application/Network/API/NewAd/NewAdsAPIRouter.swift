import Foundation
public enum NewAdsApiRouter: BaseRouter {
    case createUUID
    case addBodyToAd(adUUID: String, body: NewAdBodyModel)
    case addImageToAd(adUUID: String)
    
    public var host: String {
        switch self {
        default:
            return "staging-api-market.o.kg"
        }
    }
    
    public var path: String {
        switch self {
        case .createUUID:
            return "/api/ads-board/v1/ads/initial/"
        case .addBodyToAd(let adUUID, _):
            return "/api/ads-board/v1/ads/\(adUUID)/"
        case .addImageToAd(let adUUID):
            return "/api/ads-board/v1/ads/\(adUUID)/upload-image/"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .createUUID:
            return .post
        case .addBodyToAd:
            return .put
        case .addImageToAd:
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
        case .createUUID:
            return nil
        case .addBodyToAd(_, let model):
            
            var adBody: Parameters = [
                "title": model.title,
                "description": model.description,
                "location": 1
            ]
            
            if let categoryId = model.category {
                adBody["category"] = categoryId
            }
            
            if let adType = model.adType {
                adBody["ad_type"] = adType
            }
            
            if let contractPrice = model.contractPrice {
                if contractPrice {
                    adBody["contract_price"] = true
                } else if contractPrice == false {
                    if let price = model.price {
                        if price.count > 0 {
                            adBody["price"] = price
                        }
                    }
                    if let currency = model.currency {
                        adBody["currency"] = currency
                    }
                }
            }
            
            if let oMoneyPay = model.oMoneyPay {
                if oMoneyPay {
                    adBody["o_money_pay"] = true
                } else {
                    adBody["o_money_pay"] = false
                }
            }
            
            if let isWhatsAppEnabled = model.isWhatsAppEnabled {
                if isWhatsAppEnabled {
                    adBody["whatsapp_num_is_ident"] = true
                    if let whatsAppPhonenumber = model.whatsAppPhoneNumber {
                        adBody["whatsapp_num"] = whatsAppPhonenumber
                    } else {
                        adBody["whatsapp_num"] = ""
                    }
                }
            }
            
            if let isTelegramEnabled = model.isTelegramEnabled {
                if isTelegramEnabled {
                    adBody["telegram_profile_is_ident"] = true
                    if let telegramUsername = model.telegramUsername {
                        adBody["telegram_profile"] = telegramUsername
                    } else {
                        adBody["telegram_profile"] = ""
                    }
                }
            }
            
            if let imagesURL = model.images, imagesURL.count > 0 {
                adBody["images"] = imagesURL
            }
            
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
