import ObjectMapper

public struct NewAdsResponse: Mappable {
    public var result: String?
    public var resultCode: String?
    public var details: [String: [String]]?
    public var errorCode: Int?
    public init?(map: ObjectMapper.Map) {}
    
    public mutating func mapping(map: ObjectMapper.Map) {
        result <- map["result"]
        resultCode <- map["resultCode"]
        details <- map["details"]
        errorCode <- map["errorCode"]
    }
}

public struct NewAdsImageResponse: Mappable {
    public var result: [String: String]?
    public var resultCode: String?
    
    public init?(map: ObjectMapper.Map) {}
    
    public mutating func mapping(map: ObjectMapper.Map) {
        result <- map["result"]
        resultCode <- map["resultCode"]
    }
}
