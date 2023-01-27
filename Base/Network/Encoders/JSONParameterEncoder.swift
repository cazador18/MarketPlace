import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public func encode(with parameters: Parameters) throws -> Data {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters,
                                                        options: .prettyPrinted)
            return jsonAsData
        } catch {
            throw LocalError.parameterEncoderFailed
        }
    }
}
