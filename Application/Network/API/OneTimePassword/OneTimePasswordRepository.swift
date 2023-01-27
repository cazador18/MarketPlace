import Foundation

internal protocol OneTimePasswordRepositoryProtocol {
    func checkOneTimePassword(phoneNumber: String,
                              oneTimePassword: String,
                              completionHander: @escaping (Result<TokenResponse, NetworkError>) -> Void)
}

internal final class OneTimePasswordRepository: BaseRepository, OneTimePasswordRepositoryProtocol {
    internal func checkOneTimePassword(phoneNumber: String,
                                       oneTimePassword: String,
                                       completionHander: @escaping (Result<TokenResponse, NetworkError>) -> Void) {

        let request = OneTimePasswordAPIRouter.getToken(msisdn: phoneNumber, otp: oneTimePassword).createURLRequest()
        makeRequest(ofType: TokenResponse.self,
                    request: request,
                    accessTokenProvider: nil,
                    completion: completionHander)
    }
}
