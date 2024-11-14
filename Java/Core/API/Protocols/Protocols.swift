import Foundation


protocol APIResponse:Codable {
    associatedtype DataType: Codable
    
    var success: Bool { get }
    var data: DataType? { get }
    var error: String? { get }
}

protocol APIService {
    func fetchData<T: APIResponse>(endpoint: String) async throws -> T
}
