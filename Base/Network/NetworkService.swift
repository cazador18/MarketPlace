import Foundation
import ObjectMapper

public final class NetworkService {
    private let session: URLSession
    private let networkManager: NetworkManager
    
    internal init(session: URLSession) {
        self.session = session
        networkManager = .init()
    }
    
    internal func getData(with request: URLRequest,
                          completionHandler: @escaping (Result<Data, NetworkError>) -> Void) -> URLSessionDataTask {
        return session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            if !self.networkManager.isConnectedToNetwork(),
               let cachedData = self.getCachedData(from: request) {
                return  completionHandler(.success(cachedData))
            }
            if let error = self.validateError(data, response: response, error: error) {
                completionHandler(.failure(error))
                return
            }

            if let data = data, let response = response {
                self.saveDataToCache(with: data, and: response)
                completionHandler(.success(data))
            } else {
                completionHandler(.failure(.emptyResponse))
            }
        }
    }
    
    private func validateError(_ data: Data?, response: URLResponse?, error: Error?) -> NetworkError? {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            return error != nil ? .common(error!) : nil
        }

        guard !(200...299 ~= statusCode) else {
            return nil
        }

        guard let data = data else {
            return error != nil ? .common(error!) : nil
        }

        if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            if let message = json["message"] as? String {
                return .withMessage(message)
            }
            if let detail = json["detail"] as? String, detail == "Учетные данные не были предоставлены." {
                return .unauthorized(detail)
            }
        }

        return error != nil ? .common(error!) : nil
    }
    
    private func getCachedData(from urlRequest: URLRequest) -> Data? {
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return cachedResponse.data
        }
        return nil
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
}
