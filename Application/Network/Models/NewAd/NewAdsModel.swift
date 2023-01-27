import ObjectMapper
import Foundation

public struct NewAdsModel: Mappable {
    private var title: String?
    private var description: String?
    private var category: Int?
    private var currency: String?
    private var contractPrice: Bool?
    private var price: String?
    private var adType: String?
    private var oMoneyPay: Bool?
    private var whatsapp: String?
    private var telegram: String?
    private var location: Int?
    public init?(map: Map) {}
    public mutating func mapping(map: Map) {
        title <- map["title"]
        description <- map["description"]
        category <- map["category"]
        currency <- map["currency"]
        adType <- map["ad_type"]
        contractPrice <- map["contract_price"]
        price <- map["price"]
        oMoneyPay <- map["o_money_pay"]
        whatsapp <- map["whatsapp_num"]
        telegram <- map["telegram_profile"]
        location <- map["location"]
    }
}
