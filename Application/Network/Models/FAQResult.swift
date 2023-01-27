import ObjectMapper

public struct FAQResult: Mappable {
    
    public var count: Int?
    public var next: Int?
    public var previous: Int?
    public var results: [FAQ] = []
    
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        count <- map["count"]
        next <- map["next"]
        previous <- map["previous"]
        results <- map["results"]
    }
}

public struct FAQ: Mappable {
    
    var id: Int?
    var title: String?
    var content: String?
    
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        content <- map["content"]
    }
}
