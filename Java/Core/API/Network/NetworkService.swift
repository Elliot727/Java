import Foundation

class NetworkService: APIService {
    func fetchData<T: Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw NSError(domain: "InvalidURL", code: 0, userInfo: nil)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "HTTPError", code: 0, userInfo: nil)
        }

        do {
            let decoder = JSONDecoder()
    
            let decodedResponse = try decoder.decode(T.self, from: data)
            return decodedResponse
        } catch {
            print(error.localizedDescription)
            throw NSError(domain: "DecodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
        }
    }
}
