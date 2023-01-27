import Foundation

public struct NewAdBodyModel {
    public var title: String
    public var description: String
    
    public var category: Int?
    public var currency: String?
    public var contractPrice: Bool?
    public var price: String?
    public var adType: String?
    public var oMoneyPay: Bool?
    public var isWhatsAppEnabled: Bool?
    public var whatsAppPhoneNumber: String?
    public var isTelegramEnabled: Bool?
    public var telegramUsername: String?
    public var location: Int?
    public var images: [String]?
}

extension NewAdBodyModel: Encodable {}
