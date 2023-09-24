import SwiftUI

struct PopularMoviesList: View {

    let movies: [MovieModel]
    let isLoading: Bool
    let onScrolledAtBottom: () -> Void

    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns) {
                reposList
            }
            if isLoading {
                ProgressView()
                    .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
            }
        }
    }

    private var reposList: some View {
        ForEach(movies, id: \.id) { movie in
            PopularMovieRow(movie: movie)
                .frame(minHeight: 300)
                .padding(10)
                .onAppear {
                    if self.movies.last == movie {
                        self.onScrolledAtBottom()
                    }
                }
        }
    }
}


struct PopularMoviesList_Previews: PreviewProvider {

    static var previews: some View {
        let movies = [
            Helper.makeMovieModel(),
            Helper.makeMovieModel(),
            Helper.makeMovieModel()
        ]

        PopularMoviesList(movies: movies,
                          isLoading: true,
                          onScrolledAtBottom: {})
    }
}
