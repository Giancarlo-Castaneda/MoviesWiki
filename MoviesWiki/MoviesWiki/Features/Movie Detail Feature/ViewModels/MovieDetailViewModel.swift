import Combine
import Foundation

final class MovieDetailViewModel: ObservableObject {

    typealias DetailAlias = Result<MovieDetailModel, Error>

    // MARK: - Private Properties

    private let movieDetailRepository: MovieDetailRepository
    private let formater = CurrencyFormatter(currencyCode: "USD")
    private let runTimeFormatter = RunTimeFormatter(unitsStyle: .abbreviated)

    // MARK: Input

    @Published var movieId: Int = 0

    // MARK: Output

    @Published var movieTitle: String = ""
    @Published var backdropURL: URL?
    @Published var posterURL: URL?
    @Published var runTime: String = ""
    @Published var revenue: String = ""
    @Published var budget: String = ""
    @Published var voteAverage: String = ""
    @Published var overview: String = ""
    @Published var videos : [DetailResultModel] = []
    @Published var images: [MovieBackdropModel] = []
    @Published var GenreModels: [GenreModel] = []

    private lazy var fetchDetailPublisher: AnyPublisher<DetailAlias, Never> = {
        $movieId
            .flatMap { detailId -> AnyPublisher<DetailAlias, Never> in
                self.movieDetailRepository.fetchDetail(id: detailId)
                    .asResult()
            }
            .receive(on: DispatchQueue.main)
            .share()
            .eraseToAnyPublisher()
    }()

    // MARK: - Initialization

    init(movieDetailRepository: MovieDetailRepository) {
        self.movieDetailRepository = movieDetailRepository

        fetchDetailPublisher
            .map { result in
                switch result{
                case .success(let data):
                    return data.images?.backdrops ?? []
                case .failure(_):
                    return []
                }
            }
            .assign(to: &$images)

        fetchDetailPublisher
            .map { result in
                switch result{
                case .success(let data):
                    return data.videos?.results ?? []
                case .failure(_):
                    return []
                }
            }
            .assign(to: &$videos)

        fetchDetailPublisher
            .map({ result in
                switch result{
                case .success(let data):
                    return data.overview ?? ""
                case .failure(_):
                    return ""
                }
            })
            .assign(to: &$overview)

        fetchDetailPublisher
            .map({ result in
                switch result{
                case .success(let data):
                    let vote = Float(data.voteAverage ?? 0)/10
                    return String(format: "%.0f %%", min(vote, 1.0) * 100.0)

                case .failure(_):
                    return ""
                }
            })
            .assign(to: &$voteAverage)

        fetchDetailPublisher
            .map({ result in
                switch result{
                case .success(let data):
                    if let runtime = data.runtime {
                        return runtime == 0
                        ? ""
                        : self.runTimeFormatter.getRuntimeFormatted(value: runtime)
                    }
                    return "Popularity: \(data.runtime ?? 0)"
                case .failure(_):
                    return "Popularity: -"
                }
            })
            .assign(to: &$runTime)

        fetchDetailPublisher
            .map({ result in
                switch result{
                case .success(let data):
                    if let revenue = data.revenue {
                        return revenue == 0
                            ? "Revenue: -"
                            : "Revenue: \(self.formater.getFormattedCurrency(value: revenue))"
                    }
                    return "Revenue: -"
                case .failure(_):
                    return "Revenue: -"
                }
            })
            .assign(to: &$revenue)

        fetchDetailPublisher
            .map({ result in
                switch result{
                case .success(let data):
                    if let budget = data.budget {
                        return budget == 0
                        ? "Budget: -"
                        : "Budget: \(self.formater.getFormattedCurrency(value: data.budget ?? 0))"
                    }
                    return "Budget: -"
                case .failure(_):
                    return "Budget: -"
                }
            })
            .assign(to: &$budget)

        fetchDetailPublisher
            .map { result in
                switch result {
                case .success(let detail):
                    return detail.title ?? ""

                case .failure(_):
                    return ""
                }
            }
            .assign(to: &$movieTitle)

        fetchDetailPublisher
            .map { result in

                switch result {
                case .success(let detail):
                    if let urlString = detail.backdropPath,
                       let url = URL(string: Constants.backdropBaseURL.normalSize+urlString) {
                        return url
                    }
                    return URL(string: "")

                case .failure(_):
                    return URL(string: "")
                }
            }.assign(to: &$backdropURL)

        fetchDetailPublisher
            .map { result in

                switch result {
                case .success(let detail):
                    if let urlString = detail.posterPath,
                       let url = URL(string: Constants.posterBaseURL+urlString) {
                        return url
                    }
                    return URL(string: "")

                case .failure(_):
                    return URL(string: "")
                }
            }.assign(to: &$posterURL)

        fetchDetailPublisher
            .map { result in
                switch result {
                case .success(let data):
                    return data.genres ?? []
                case .failure(_):
                    return []
                }
            }
            .assign(to: &$GenreModels)
    }
}
