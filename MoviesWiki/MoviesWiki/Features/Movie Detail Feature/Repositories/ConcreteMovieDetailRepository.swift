import Combine
import Foundation

final class ConcreteMovieDetailRepository: MovieDetailRepository {

    // MARK: - Private Properties

    private let networkProvider: NetworkingProvider

    // MARK: - Initialization

    init(networkProvider: NetworkingProvider) {
        self.networkProvider = networkProvider
    }

    // MARK: - Internal Methods

    func fetchDetail(id: Int) -> AnyPublisher<MovieDetailModel, Error> {
        let endpoint = RequestAPIModel.fetchDetailGET(id: id)

        return networkProvider.request(endpoint)
    }
}
