import Foundation

@Observable
class CoffeeViewModel {
     var data: [Coffee]?
    var errorMessage: String?
    var apiService:APIServiceImpl
    var dataManager = DataManager()
    init(data: [Coffee]? = nil, errorMessage: String? = nil, apiService: APIServiceImpl) {
        self.data = data
        self.errorMessage = errorMessage
        self.apiService = apiService
    }
    
    func fetchData() async {
        do {
            if let response: [Coffee] = dataManager.getData("coffee"){
                self.data = response
            }
            else{
                let response: [Coffee] = try await apiService.fetchData(endpoint: "https://fake-coffee-api.vercel.app/api")
                dataManager.setData(response, forKey: "coffee")
                self.data = response
            }

        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
