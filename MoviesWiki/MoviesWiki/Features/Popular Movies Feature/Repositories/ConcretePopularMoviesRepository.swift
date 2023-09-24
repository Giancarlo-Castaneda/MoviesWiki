import Combine
import Foundation

final class ConcretePopularMoviesRepository: PopularMoviesRepository {

    // MARK: - Private Properties

    private var networkingProvider: NetworkingProvider

    // MARK: - Initialization

    init(networkingProvider: NetworkingProvider) {
        self.networkingProvider = networkingProvider
    }

    // MARK: - Internal Methods

    func fetchPopularMovies(page: String) -> AnyPublisher<MoviePaginationModel, Error> {
        let endpoint = RequestAPIModel.moviePopularGET(page: page)

        return networkingProvider.request(endpoint)
    }
}
