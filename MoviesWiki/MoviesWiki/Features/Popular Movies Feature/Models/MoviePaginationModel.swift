import Foundation

// MARK: - PopularMovieModel

struct MoviePaginationModel: Codable {
    let page: Int
    let results: [MovieModel]
    let totalPages: Int
    let totalResults: Int
}
