import Foundation
import ObjectMapper

struct RefreshTokenResponse: Mappable {
    var accessToken: String!

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        accessToken <- map["access_token"]
    }
}
