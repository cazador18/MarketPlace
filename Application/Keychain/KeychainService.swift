import Foundation

import KeychainAccess
import ObjectMapper

enum KeychainKeys {
    static let accessToken = "accessToken"
}

protocol KeychainServiceProtocol {
    func get<Value: Mappable>(for key: String) throws -> Value?

    func set<Value: Mappable>(_ value: Value?, for key: String) throws
}

class KeychainService: KeychainServiceProtocol {

    let bundleId: String
    let keychain: Keychain

    init() {
        bundleId = Bundle.main.bundleIdentifier!
        keychain = Keychain(service: bundleId)
    }

    func get<Value: Mappable>(for key: String) throws -> Value? {
        if let data = keychain[data: key] {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                return Mapper<Value>().map(JSON: json)
            }
        }
        return nil
    }

    func set<Value: Mappable>(_ value: Value?, for key: String) throws {
        if let value = value {
            let json = value.toJSON()
            let data = try JSONSerialization.data(withJSONObject: json)
            keychain[data: key] = data
        } else {
            keychain[data: key] = nil
        }
    }
    
    func delete() {
        try? keychain.remove(KeychainKeys.accessToken)
    }
}
