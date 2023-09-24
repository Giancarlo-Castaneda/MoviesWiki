import SwiftUI

struct PopularMovieRow: View {

    @EnvironmentObject var viewModel: MovieDetailViewModel
    let movie: MovieModel
    @State var progressValue: Float = 0.0
    @State private var isActive = false

    var body: some View {

        VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading) {
                if let url = URL(string: Constants.posterBaseURL+(movie.posterPath ?? "")) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                }
                ProgressPieView(progress: $progressValue)
                    .frame(width: 40.0, height: 40.0)
                    .padding(10.0)
                    .opacity(0.8)
                    .offset(y: 25)
            }
            Text(movie.originalTitle ?? "")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.top, 20)
                .padding(.horizontal)
            Text(movie.releaseDate ?? "")
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.bottom, 10)
        }
        .background(Color.black)
        .background(
            NavigationLink(
                destination: MovieDetailScreen(movieId: movie.id ?? 0).environmentObject(viewModel),
                isActive: $isActive,
                label: {
                    EmptyView()
                }
            )
        )
        .cornerRadius(20)
        .modifier(ShadowModifier(shadowColor: .white))
        .onTapGesture {
            self.isActive = true
        }
        .onAppear {
            progressValue = Float(movie.voteAverage ?? 0) / 10
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct PopularMovieRow_Previews: PreviewProvider {

    static var previews: some View {
        PopularMovieRow(movie: Helper.makeMovieModel())
            .environmentObject(
                MovieDetailViewModel(
                    movieDetailRepository: ConcreteMovieDetailRepository(
                        networkProvider: ConcreteNetworkingProvider(jsonDecoder: JSONDecoder())
                    )
                )
            )
    }
}
