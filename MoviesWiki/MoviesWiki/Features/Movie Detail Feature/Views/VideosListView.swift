import SwiftUI

struct VideosListView: View {

    var rows: [GridItem] = Array(repeating: .init(.fixed(200)), count: 1)
    let videos: [DetailResultModel]

    var body: some View {

        VStack(alignment: .leading) {
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(.gray)
                .padding(.horizontal)

            Text("MOVIE_MEDIA")
                .foregroundColor(.white)
                .bold()
                .font(.title2)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, alignment: .center) {
                    ForEach(videos, id: \.id) { video in
                        VStack {
                            if let url = getURL(urlstring: video.key) {
                                WebView(url: url)
                                    .frame(width: 300, height: 160)
                            }

                            Text(video.name ?? "")
                                .padding(.top)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(.white)
                                .font(.callout)
                        }
                        .cornerRadius(10)
                        .padding()
                        .shadow(color: .white.opacity(0.5), radius: 10)
                    }
                }
            }

            .frame(maxHeight: 300)
        }
        .frame(maxWidth: .infinity)
    }

    func getURL(urlstring: String?) -> URL? {
        if let string = urlstring, let url = URL(string: Constants.youtubeEmbed+string) {
            return url
        }
        return nil
    }
}

struct ActorsListView_Previews: PreviewProvider {
    static var previews: some View {
        VideosListView(videos: [DetailResultModel(iso639_1: nil,
                                                    iso3166_1: nil,
                                                    name: "The Last Kingdom | Series 1 Full TrailerThe Last Kingdom | Series 1 Full Trailer",
                                                    key: "WxPApTGWwas",
                                                    publishedAt: nil,
                                                    site: "YouTube",
                                                    size: nil,
                                                    type: "Trailer",
                                                    official: nil,
                                                    id: nil)])
    }
}
