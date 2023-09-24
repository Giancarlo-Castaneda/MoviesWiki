import Foundation

enum Constants {

    enum backdropBaseURL {
        static private let backdropSize = "w780"
        static let normalSize = imageBase+backdropSize
    }

    static let Apiv3Key = "e2c11c9b86cb2ae8bd6a0726aa097d6d"
    static let language = "es-MX"
    static let languageShort = "es"
    static let baseURL = "api.themoviedb.org"
    static let apiVersion = "3"
    static let youtubeEmbed = "https://www.youtube.com/embed/"
    static private let posterSize = "w500"
    static private let imageBase = "https://image.tmdb.org/t/p/"
    static let posterBaseURL = imageBase+posterSize
}
