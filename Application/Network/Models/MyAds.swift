import ObjectMapper
import Foundation

public struct MyProfileAdResponse: Mappable {
    
    public var results: [MyAds]?
    public var next: Int?
    
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        results  <- map["result.results"]
        next  <- map["result.next"]
    }
}

public struct MyAds: Mappable {
    public var id: Int?
    public var uuid: String?
    public var title: String?
    public var address: String?
    public var oMoneyPay: Bool?
    public var price: String?
    public var latitude, longitude: String?
    public var contractPrice: Bool?
    public var currency: String?
    public var description: String?
    public var status: String?
    public var modifiedAt: String?
    public var whatsapp: String?
    public var telegram: String?
    public var adType: String?
    public var isOwn: Bool?
    public var category: MyProfileCategory?
    public var categoryID: Int?
    public var author: Author?
    public var favorite: Bool?
    public var location: MyProfileLocation?
    public var minifyImages: [String]?
    public var viewCount: Int?
    public var currencyUsd: Double?
    
    public init?(map: Map) { }
    
    public mutating func mapping(map: Map) {
        id <- map["id"]
        uuid <- map["uuid"]
        title <- map["title"]
        address <- map["address"]
        price <- map["price"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        contractPrice <- map["contractPrice"]
        currency <- map["currency"]
        description <- map["description"]
        status <- map["status"]
        modifiedAt <- map["modified_at"]
        isOwn <- map["is_own"]
        whatsapp <- map["whatsapp_num"]
        telegram <- map["telegram_profile"]
        category <- map["category"]
        author <- map["author"]
        adType <- map["ad_type"]
        favorite <- map["favorite"]
        location <- map["location"]
        minifyImages <- map["minify_images"]
        viewCount <- map["view_count"]
        currencyUsd <- map["currency_usd"]
    }
}

public struct MyProfileCategory: Mappable {
    public var name: String?
    
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        name <- map["name"]
    }
}

public struct MyProfileLocation: Mappable {
    public var name: String?
    
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        name <- map["name"]
    }
}
