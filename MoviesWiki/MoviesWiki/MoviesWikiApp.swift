import SwiftUI

@main
struct MoviesWikiApp: App {

    @StateObject var popularMoviesViewModel = PopularMoviesViewModel(
        repository: ConcretePopularMoviesRepository(
            networkingProvider: ConcreteNetworkingProvider(jsonDecoder: jsonDecoder)
        )
    )
    @StateObject var detailViewModel = MovieDetailViewModel(
        movieDetailRepository: ConcreteMovieDetailRepository(
            networkProvider: ConcreteNetworkingProvider(jsonDecoder: JSONDecoder())
        )
    )

    var body: some Scene {
        WindowGroup {
            NavigationView {
                PopularMoviesScreen()
                    .environmentObject(popularMoviesViewModel)
                    .environmentObject(detailViewModel)
            }
        }
    }
}

var jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()
