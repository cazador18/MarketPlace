import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    func encode(with parameters: Parameters) throws -> Data
}
