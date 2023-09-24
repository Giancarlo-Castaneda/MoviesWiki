import Foundation

extension RequestAPIModel {

    static func moviePopularGET(page: String) -> RequestAPIModel {
        let query = [
            URLQueryItem(name: "api_key", value: Constants.Apiv3Key),
            URLQueryItem(name: "language", value: Constants.language),
            URLQueryItem(name: "page", value: page)
        ]

        return .init(path: "/3/movie/popular", method: .get, body: nil, queryItems: query)
    }
}
