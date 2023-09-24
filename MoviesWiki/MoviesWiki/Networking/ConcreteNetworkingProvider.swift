import Combine
import Foundation

final class ConcreteNetworkingProvider: NetworkingProvider {

    // MARK: - Private Properties

    private let jsonDecoder: JSONDecoder

    // MARK: - Initialization

    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }

    // MARK: - Private Methods

    private func createURLComponents(endpoint: RequestType) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems

        return urlComponents
    }

    private func createRequest(endpoint: RequestType) throws -> URLRequest {
        guard
            let url = createURLComponents(endpoint: endpoint).url
        else { throw RequestError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        }

        return request
    }

    private func checkResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let urlResponse = output.response as? HTTPURLResponse
        else { throw RequestError.noResponse }

        switch urlResponse.statusCode {
        case 200..<300:
            return output.data

        case 400:
            throw RequestError.badRequest

        case 500..<600:
            let apiError = try self.jsonDecoder.decode(ErrorResponse.self, from: output.data)
            throw RequestError.serverError(statusCode: urlResponse.statusCode,
                                       reason: apiError.statusMessage,
                                       retryAfter: urlResponse.value(forHTTPHeaderField: "Retry-After"))

        default:
            throw RequestError.unexpectedStatusCode(statusCode: urlResponse.statusCode)
        }
    }

    // MARK: - Internal Methods

    func request<T: Decodable>(_ endpoint: RequestType) -> AnyPublisher<T, Error> {
        guard
            let request = try? createRequest(endpoint: endpoint)
        else {
            return Fail(error: RequestError.invalidRequest)
                .eraseToAnyPublisher()
        }

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { try self.checkResponse(output: $0) }
            .decode(type: T.self, decoder: jsonDecoder)
            .mapError { error in
                RequestError.decode(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
