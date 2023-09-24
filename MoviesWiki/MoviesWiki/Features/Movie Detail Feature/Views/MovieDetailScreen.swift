import SwiftUI

struct MovieDetailScreen: View {

    @EnvironmentObject var viewModel: MovieDetailViewModel

    let movieId: Int

    var body: some View {

        ScrollView {
            VStack(alignment: .leading) {
                MovieDetailHeaderView()

                Text("MOVIE_OVERVIEW")
                    .bold()
                    .padding(10)
                    .font(.title2)
                    .foregroundColor(.white)

                ExpandableTextView(viewModel.overview, lineLimit: 4)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10))
                    .foregroundColor(.gray)
                    .font(.body)

                if !viewModel.videos.isEmpty {
                    VideosListView(videos: viewModel.videos)
                        .padding(.top, 10)
                }
                if !viewModel.images.isEmpty {
                    GalleryView()
                        .padding(.top, 10)
                }

            }
            .frame(maxWidth: .infinity)
            .onAppear {
                viewModel.movieId = movieId
            }
        }
        .background(Color("AppBackground"))
        .navigationBarTitle("MOVIE_TITLE")

    }
}

struct MovieDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailScreen(movieId: 568124)
            .environmentObject(
                MovieDetailViewModel(
                    movieDetailRepository: ConcreteMovieDetailRepository(
                        networkProvider: ConcreteNetworkingProvider(jsonDecoder: JSONDecoder())
                    )
                )
            )
    }
}
