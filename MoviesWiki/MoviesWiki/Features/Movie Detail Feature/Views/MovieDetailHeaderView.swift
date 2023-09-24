import SwiftUI

struct MovieDetailHeaderView: View {

    @EnvironmentObject var viewModel: MovieDetailViewModel

    var body: some View {

        ZStack(alignment: .topLeading) {
            if let url = viewModel.backdropURL {
                ZStack(alignment: .bottom) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }

                    Rectangle()
                        .foregroundColor(.clear)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.clear, .black]),
                                           startPoint: .top,
                                           endPoint: .bottom)
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: 220)
                .cornerRadius(40, corners: [.bottomLeft, .bottomRight])
            }

            HStack {
                if viewModel.backdropURL == nil, let url = viewModel.posterURL {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 150, height: 230)
                    .shadow(color: .gray, radius: 5)
                }
                VStack(alignment: .leading) {
                    Text(viewModel.movieTitle)
                        .foregroundColor(.white)
                        .bold()
                        .font(.title2)
                    Text(viewModel.voteAverage)
                        .foregroundColor(.purple)
                    Text(viewModel.runTime)
                        .foregroundColor(.white)
                    Text(viewModel.budget)
                        .foregroundColor(.white)
                    Text(viewModel.revenue)
                        .foregroundColor(.white)
                }
                .padding(.leading, 10)
            }
            .padding(.top, viewModel.backdropURL != nil ? 170 : 0)
        }
    }
}

struct MovieDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailHeaderView()
            .environmentObject(
                MovieDetailViewModel(
                    movieDetailRepository: ConcreteMovieDetailRepository(
                        networkProvider: ConcreteNetworkingProvider(jsonDecoder: JSONDecoder())
                    )
                )
            )
    }
}
