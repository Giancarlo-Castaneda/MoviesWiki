import Foundation

// MARK: - DetailResultModel

struct DetailResultModel: Codable, Identifiable {
    let iso639_1: String?
    let iso3166_1, name, key, publishedAt: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key
        case publishedAt = "published_at"
        case site, size, type, official, id
    }
}
