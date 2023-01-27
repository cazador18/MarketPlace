import ObjectMapper

public struct SearchByWordCategoryResult: Mappable {
    public var results: [Category]?
    
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        results <- map["results"]
    }
}
