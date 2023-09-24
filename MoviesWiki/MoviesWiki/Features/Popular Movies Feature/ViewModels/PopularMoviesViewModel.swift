import Combine
import Foundation

final class PopularMoviesViewModel: ObservableObject {

    // MARK: - Private Properties
    @Published private(set) var state = State()
    struct State {
        var repos: [MovieModel] = []
        var page: Int = 1
        var canLoadNextPage = true
    }
    private var subscriptions = Set<AnyCancellable>()
    private let repository: PopularMoviesRepository

    // MARK: - Initialization

    init(repository: PopularMoviesRepository) {
        self.repository = repository
    }

    // MARK: - Private Methods

    private func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break

        case .failure:
            state.canLoadNextPage = false
        }
    }

    private func onReceive(_ batch: MoviePaginationModel) {
        state.repos += batch.results
        state.page += 1
        state.canLoadNextPage = batch.totalPages >= state.page
    }

    // MARK: - Internal Methods

    func fetchMoviesNextPageIfPossible() {
        guard
            state.canLoadNextPage
        else { return }
        repository.fetchPopularMovies(page: "\(state.page)")
            .sink(receiveCompletion: onReceive,
                  receiveValue: onReceive)
            .store(in: &subscriptions)
    }
}
