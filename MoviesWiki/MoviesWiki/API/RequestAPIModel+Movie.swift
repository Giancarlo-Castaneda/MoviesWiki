import Foundation

extension RequestAPIModel {

    static func fetchDetailGET(id: Int) -> RequestAPIModel {
        let query = [
            URLQueryItem(name: "append_to_response", value: "videos,images"),
            URLQueryItem(name: "include_image_language", value: Constants.languageShort),
            URLQueryItem(name: "language", value: Constants.language),
            URLQueryItem(name: "api_key", value: Constants.Apiv3Key)
        ]

        return .init(path: "/3/movie/\(id)", method: .get, body: nil, queryItems: query)
    }

    static func moviePopularGET(page: String) -> RequestAPIModel {
        let query = [
            URLQueryItem(name: "api_key", value: Constants.Apiv3Key),
            URLQueryItem(name: "language", value: Constants.language),
            URLQueryItem(name: "page", value: page)
        ]

        return .init(path: "/3/movie/popular", method: .get, body: nil, queryItems: query)
    }
}
