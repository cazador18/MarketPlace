import ObjectMapper

public struct Author: Mappable {
    public var id: Int?
    public var msisdn: String?
    public var location: Location?
    public var verified: Bool?
    public var blockType, username, avatar, partnerType: String?
    public var rating: Int?
    public var contactNumber: String?
    
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        id <- map["id"]
        msisdn <- map["msisdn"]
        location <- map["location"]
        verified <- map["verified"]
        blockType <- map["block_type"]
        username <- map["username"]
        avatar <- map["avatar"]
        partnerType <- map["partner_type"]
        rating <- map["rating"]
        contactNumber <- map["contact_number"]
    }
}
