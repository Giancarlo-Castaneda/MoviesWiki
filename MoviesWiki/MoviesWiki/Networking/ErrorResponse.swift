import Foundation

// MARK: - ErrorResponse

struct ErrorResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    let success: Bool
}
