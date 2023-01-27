import Foundation

import ObjectMapper

struct ResultResponse<Model: Mappable>: Mappable {

    var result: Model?
    var resultCode: String?
    var details: String?
    var errorCode: Int?

    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        result <- map["result"]
        resultCode <- map["resultCode"]
        details <- map["details"]
        errorCode <- map["errorCode"]
    }
}
