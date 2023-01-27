import Foundation
import ObjectMapper
public struct DeleteAdsResponse: Mappable {
    private var result: [Any]?
    private var resultCode: String?
    private var details: String?
    private var errorCode: Int?
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        result <- map["result"]
        resultCode <- map["resultCode"]
        details <- map["details"]
        errorCode <- map["errorCode"]
    }
}
