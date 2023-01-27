import Foundation

public enum LocalError: LocalizedError {
    case unknown
    case parameterEncoderFailed

    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Непредвиденная ошибка"
        case .parameterEncoderFailed:
            return "Ошибка кодировки параметров"
        }
    }
}

public enum NetworkError: LocalizedError {
    case emptyResponse
    case failedMapping
    case common(Error)
    case withMessage(String)
    case unauthorized(String)

    public var errorDescription: String? {
        switch self {
        case .emptyResponse:
            return "Пустой ответ"
        case .failedMapping:
            return ""
        case .common(let error):
            return error.localizedDescription
        case .withMessage(let string):
            return string
        case .unauthorized(let string):
            return string
        }
    }
}
