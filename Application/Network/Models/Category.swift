import ObjectMapper

struct ResultCategory: Mappable {
    public var result: [Category]?
    public var resultCode, details: String?
    public var errorCode: Int?
    
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        result <- map["result"]
        resultCode <- map["resultCode"]
        details <- map["details"]
        errorCode <- map["errorCode"]
    }
}

public struct Category: Mappable {
    public var id: Int?
    public var parent: Int?
    public var name: String?
    public var parentFilters, delivery: Bool?
    public var orderNum: Int?
    public var isPopular, hasMap, requiredPrice: Bool?
    public var iconImg: String?
    public var darkIconImg, categoryType: String?
    public var linkedCategory: [Any]?
    public var filters, adType: [Int]?
    public var hasDynamicFilter: Bool?
    public var subCategories: [Category]?
    
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        parentFilters <- map["parent_filters"]
        delivery <- map["delivery"]
        orderNum <- map["order_num"]
        isPopular <- map["is_popular"]
        hasMap <- map["has_map"]
        requiredPrice <- map["required_price"]
        iconImg <- map["icon_img"]
        darkIconImg <- map["dark_icon_img"]
        categoryType <- map["category_type"]
        parent <- map["parent"]
        hasDynamicFilter <- map["has_dynamic_filter"]
        linkedCategory <- map["linked_category"]
        filters <- map["filters"]
        adType <- map["adType"]
        subCategories <- map["sub_categories"]
    }
}
