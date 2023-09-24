import SwiftUI

struct GalleryView: View {

    @EnvironmentObject var viewModel: MovieDetailViewModel

    let rows = [
        GridItem(.flexible())
    ]

    var body: some View{
        VStack(alignment:.leading) {
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(.gray)
                .padding(.horizontal)

            Text("MOVIE_GALLERY")
                .foregroundColor(.white)
                .bold()
                .font(.title2)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows:rows) {
                    ForEach(viewModel.images, id: \.self) { image in
                        if let url = URL(string: Constants.backdropBaseURL.normalSize+(image.filePath ?? "")) {
                            AsyncImage(url: url) { image in
                                image.resizable(resizingMode: .stretch)
                            } placeholder: {
                                ProgressView()
                            }
                            .cornerRadius(10)
                            .padding()
                            .frame(width: 300, height: 200)
                            .shadow(color: .white.opacity(0.5), radius: 10)
                        }
                    }
                }
            }
            .frame(height: 200)
        }
        .frame(maxWidth: .infinity)
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
            .environmentObject(
                MovieDetailViewModel(
                    movieDetailRepository: ConcreteMovieDetailRepository(
                        networkProvider: ConcreteNetworkingProvider(jsonDecoder: JSONDecoder())
                    )
                )
            )
    }
}
