import Foundation

public protocol BaseRouter {
    typealias HTTPHeaders = [String: String]
    
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameter: [URLQueryItem]? { get }
    var httpBody: Data? { get }
    var httpHeaders: HTTPHeaders? { get }
    var port: Int? { get }
}

extension BaseRouter {
    private var scheme: String {
        return "https"
    }
    
    internal func createURLRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryParameter
        urlComponents.port = port
        
        guard let url = urlComponents.url else {
            fatalError(URLError(.unsupportedURL).localizedDescription)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = httpBody
        
        httpHeaders?.forEach { (header) in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
    
    internal func createUploadImageRequest(image: Data) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryParameter
        urlComponents.port = port
        
        guard let url = urlComponents.url else {
            fatalError(URLError(.unsupportedURL).localizedDescription)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = httpBody
        
        httpHeaders?.forEach { (header) in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        let boundary = "Boundary-\(UUID().uuidString)"
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let httpBody = NSMutableData()
        httpBody.append(convertFileData(fieldName: "image",
                                        fileName: "imagename.png",
                                        mimeType: "image/png",
                                        fileData: image,
                                        using: boundary))

        httpBody.appendString("--\(boundary)--")

        urlRequest.httpBody = httpBody as Data
        
        return urlRequest
    }
}

extension BaseRouter {
    internal func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
        let data = NSMutableData()
        
        data.appendString("--\(boundary)\r\n")
        data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        data.appendString("Content-Type: \(mimeType)\r\n\r\n")
        data.append(fileData)
        data.appendString("\r\n")
        
        return data as Data
    }
}

extension NSMutableData {
  internal func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
