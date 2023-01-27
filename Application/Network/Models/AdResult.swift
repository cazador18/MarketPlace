import ObjectMapper

public struct AdResult: Mappable {
    public var count, next: Int?
    public var previous: Int?
    public var results: [AdElement]?
    
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        count <- map["result.count"]
        next <- map["result.next"]
        previous <- map["result.previous"]
        results <- map["result.results"]
    }
}

public struct AdElement: Mappable {
    public var id: Int?
    public var uuid, title, description, adType: String?
    public var authorID: Int?
    public var price: Any?
    public var oldPrice, currency, status: String?
    public var delivery: Bool?
    public var createdAt, address: String?
    public var oMoneyPay: Bool?
    public var whatsappNum: String?
    public var whatsappNumIsIdent: Bool?
    public var removedAt: String?
    public var openingAt: String?
    public var contractPrice: Bool?
    public var commentary, priceSort: String?
    public var publishedAt: String?
    public var latitude, longitude: String?
    public var moderatorID: Int?
    public var telegramProfile: String?
    public var telegramProfileIsIdent: Bool?
    public var modifiedAt: String?
    public var hasImage: Bool?
    public var category: Category?
    public var detail: Int?
    public var location: Location?
    public var promotionType: String?
    public var isOwn: Bool?
    public var author: Author?
    public var favorite: Bool?
    public var images, minifyImages: [String]?
    public var complaintCount, reviewCount, viewCount: Int?
    public var currencyUsd: Double?
    
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        id <- map["id"]
        uuid <- map["uuid"]
        title <- map["title"]
        description <- map["description"]
        adType <- map["ad_type"]
        authorID <- map["author_id"]
        price <- map["price"]
        oldPrice <- map["old_price"]
        currency <- map["currency"]
        status <- map["status"]
        delivery <- map["delivery"]
        createdAt <- map["created_at"]
        address <- map["address"]
        oMoneyPay <- map["o_money_pay"]
        whatsappNum <- map["whatsapp_num"]
        whatsappNumIsIdent <- map["whatsapp_num_is_ident"]
        removedAt <- map["removed_at"]
        openingAt <- map["opening_at"]
        contractPrice <- map["contract_price"]
        commentary <- map["commentary"]
        priceSort <- map["price_sort"]
        publishedAt <- map["published_at"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        moderatorID <- map["moderator_id"]
        telegramProfile <- map["telegram_profile"]
        telegramProfileIsIdent <- map["telegram_profile_is_ident"]
        modifiedAt <- map["modified_at"]
        hasImage <- map["has_image"]
        category <- map["category"]
        detail <- map["detail"]
        location <- map["location"]
        promotionType <- map["promotion_type"]
        isOwn <- map["is_own"]
        author <- map["author"]
        favorite <- map["favorite"]
        images <- map["images"]
        minifyImages <- map["minify_images"]
        complaintCount <- map["complaint_count"]
        reviewCount <- map["review_count"]
        viewCount <- map["view_count"]
        currencyUsd <- map["currency_usd"]
    }
}
