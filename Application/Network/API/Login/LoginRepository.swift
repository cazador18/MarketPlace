import Foundation
import ObjectMapper

internal protocol LoginRepositoryProtocol {
    func login(phoneNumber: String, password: String, completionHander: @escaping (Result<TokenResponse, NetworkError>) -> Void)
}

internal final class LoginRepository: BaseRepository, LoginRepositoryProtocol {
    internal func login(phoneNumber: String, password: String, completionHander: @escaping (Result<TokenResponse, NetworkError>) -> Void) {
        let request = LoginAPIRouter.getToken(msisdn: phoneNumber, password: password).createURLRequest()
        makeRequest(ofType: TokenResponse.self,
                    request: request,
                    accessTokenProvider: nil,
                    completion: completionHander)
    }
}
