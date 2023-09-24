import Combine
import Foundation

public protocol NetworkingProvider {

    func request<T: Codable>(_ req: RequestType) -> AnyPublisher<T, Error>
}
