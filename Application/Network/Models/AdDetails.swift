import Foundation
import ObjectMapper

public struct AdDetails: Mappable {

    var id: Int?
    var uuid: String?
    var images: [URL]?
    var minifyImages: [URL]?
    var title: String?
    var description: String?
    var price: String?
    var currency: String?
    var status: String?
    var oMoneyPay: Bool?
    var isVerified: Bool?
    var author: Author?
    var category: AdDetailsCategory?
    var publishedDate: Date?
    var adType: String?
    var location: Location?
    var address: String?
    var whatsappNum: String?
    var telegramProfile: String?

    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        id <- map["id"]
        uuid <- map["uuid"]
        images <- (map["images"], URLTransform())
        minifyImages <- (map["minify_images"], URLTransform())
        title <- map["title"]
        description <- map["description"]
        price <- map["price"]
        currency <- map["currency"]
        status <- map["status"]
        oMoneyPay <- map["o_money_pay"]
        isVerified <- map["verified"]
        author <- map["author"]
        category <- map["category"]
        publishedDate <- (map["published_at"], DateTransform())
        adType <- map["ad_type"]
        location <- map["location"]
        address <- map["address"]
        whatsappNum <- map["whatsapp_num"]
        telegramProfile <- map["telegram_profile"]
    }
}

public struct AdDetailsCategory: Mappable {

    var name: String?
    var parent: AdDetailsParentCategory?

    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        name <- map["name"]
        parent <- map["parent"]
    }
}

public struct AdDetailsParentCategory: Mappable {
    var name: String?

    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        name <- map["name"]
    }
}

private class DateTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String

    public let dateFormatter: ISO8601DateFormatter

    init() {
        dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [
            .withYear, .withMonth, .withDay, .withDashSeparatorInDate,
            .withTime, .withFractionalSeconds, .withColonSeparatorInTime
        ]
    }

    open func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            return dateFormatter.date(from: dateString)
        }
        return nil
    }

    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
