import Foundation

import ObjectMapper

internal protocol RegistrationRepositoryProtocol {
    func registration(phoneNumber: String,
                      password: String,
                      password2: String,
                      completionHander: @escaping (Result<Void, NetworkError>) -> Void)
}

internal final class RegistrationRepository: BaseRepository, RegistrationRepositoryProtocol {
    internal func registration(phoneNumber: String,
                               password: String,
                               password2: String,
                               completionHander: @escaping (Result<Void, NetworkError>) -> Void) {
        let request = RegistrationAPIRouter.register(msisdn: phoneNumber,
                                                     password: password,
                                                     password2: password2).createURLRequest()
        service.getData(with: request) { result in
            switch result {
            case .success:
                completionHander(.success(()))
            case .failure(let error):
                completionHander(.failure(error))
            }
        }.resume()
    }
}
