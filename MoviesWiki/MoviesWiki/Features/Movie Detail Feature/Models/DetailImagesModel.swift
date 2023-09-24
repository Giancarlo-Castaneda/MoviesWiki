import Foundation

// MARK: - DetailImagesModel

struct DetailImagesModel: Codable {
    let backdrops, logos, posters: [MovieBackdropModel]?
}
