import ObjectMapper

public struct Location: Mappable {
    public var id: Int?
    public var name, locationType: String?
    public var orderNum: Int?
    public var isPopular: Bool?
    public var parent: Int?
    public var searchByName: String?

    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        locationType <- map["location_type"]
        orderNum <- map["orderNum"]
        isPopular <- map["is_popular"]
        parent <- map["parent"]
        searchByName <- map["search_by_name"]
    }
}
