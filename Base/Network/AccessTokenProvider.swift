import Foundation

public protocol AccessTokenProviderProtocol {

    var token: TokenResponse? { get }

    func update(with accessToken: String)
}

class AccessTokenProvider: AccessTokenProviderProtocol {

    let keychainService: KeychainServiceProtocol

    init(keychainService: KeychainServiceProtocol) {
        self.keychainService = keychainService
    }

    var token: TokenResponse? {
        return try? keychainService.get(for: KeychainKeys.accessToken)
    }

    func update(with accessToken: String) {
        var token: TokenResponse? = try? keychainService.get(for: KeychainKeys.accessToken)
        token?.accessToken = accessToken
        try? keychainService.set(token, for: KeychainKeys.accessToken)
    }
}
