import SwiftUI

@main
struct MoviesWikiApp: App {

    @StateObject var popularMoviesViewModel = PopularMoviesViewModel(
        repository: ConcretePopularMoviesRepository(
            networkingProvider: ConcreteNetworkingProvider(jsonDecoder: jsonDecoder)
        )
    )

    var body: some Scene {
        WindowGroup {
            PopularMoviesScreen()
                .environmentObject(popularMoviesViewModel)
        }
    }
}

var jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()
