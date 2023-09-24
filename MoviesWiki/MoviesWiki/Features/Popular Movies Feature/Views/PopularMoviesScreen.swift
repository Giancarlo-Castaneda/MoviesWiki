import SwiftUI

struct PopularMoviesScreen: View {

    @EnvironmentObject
    var viewModel: PopularMoviesViewModel

    var body: some View {
        PopularMoviesList(
            movies: viewModel.state.repos,
            isLoading: viewModel.state.canLoadNextPage,
            onScrolledAtBottom: viewModel.fetchMoviesNextPageIfPossible
        )
        .background(Color.black)
        .onAppear(perform: viewModel.fetchMoviesNextPageIfPossible)
    }
}

struct PopularMoviesScreen_Previews: PreviewProvider {

    static var previews: some View {
        PopularMoviesScreen()
            .environmentObject(
                PopularMoviesViewModel(
                    repository: ConcretePopularMoviesRepository(
                        networkingProvider: ConcreteNetworkingProvider(jsonDecoder: JSONDecoder())
                    )
                )
            )
    }
}
