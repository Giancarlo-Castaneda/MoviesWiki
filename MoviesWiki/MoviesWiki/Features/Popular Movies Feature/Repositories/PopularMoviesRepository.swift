import Combine
import Foundation

protocol PopularMoviesRepository {

    func fetchPopularMovies(page: String) -> AnyPublisher<MoviePaginationModel, Error>
}
