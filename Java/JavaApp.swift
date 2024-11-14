import SwiftUI

@main
struct JavaApp: App {
    @State var coffeeViewModel = CoffeeViewModel(apiService: APIServiceImpl())
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(coffeeViewModel)
        }
    }
}
