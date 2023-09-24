import Combine
import Foundation

protocol MovieDetailRepository {

    func fetchDetail(id: Int) -> AnyPublisher<MovieDetailModel, Error>
}
