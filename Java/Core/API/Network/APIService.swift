import Foundation

class APIServiceImpl: APIService {
    private let networkService = NetworkService()

    func fetchData<T: Decodable>(endpoint: String) async throws -> T {
        return try await networkService.fetchData(endpoint: endpoint)
    }
}
