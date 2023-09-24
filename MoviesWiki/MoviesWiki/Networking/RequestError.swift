import Foundation

public enum RequestError: Error {
    case decode(Error)
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode(statusCode: Int)
    case unknown
    case badRequest
    case serverError(statusCode: Int, reason: String? = nil, retryAfter: String? = nil)
    case invalidRequest
}

// MARK: - LocalizedError

extension RequestError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case let .decode(error):
            return "Decode error: " + error.localizedDescription

        case .invalidRequest:
            return "Invalid request"

        case .unauthorized:
            return "Session expired"

        case .invalidURL:
            return "Invalid URL"

        case .noResponse,
                .unknown:
            return "Unknown error"

        case let .unexpectedStatusCode(statusCode):
            return "Unexpected Status Code: \(statusCode)"

        case .badRequest:
            return "Bad request"

        case let .serverError(statusCode, reason, retryAfter):
            return "Server error with code \(statusCode), reason: \(reason ?? "no reason given"), retry after: \(retryAfter ?? "no retry after provided")"
        }
    }
}
