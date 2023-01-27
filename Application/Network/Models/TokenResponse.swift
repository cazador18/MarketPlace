import Foundation
import ObjectMapper

public struct TokenResponse: Mappable {
    public var accessToken: String!
    public var refreshToken: String!
    public var expiresIn: Int = 1800 
    private let requestedAt = Date()
    
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        accessToken   <- map["access_token"]
        refreshToken  <- map["refresh_token"]
    }
}

extension TokenResponse {
    var expiresAt: Date {
        Calendar.current.date(byAdding: .second, value: expiresIn, to: requestedAt) ?? Date()
    }
}
