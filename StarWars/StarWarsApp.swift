import SwiftUI

@main
struct StarWarsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: ViewModel(
                    searchClient: SearchClient(),
                    peopleClient: PeopleClient()
                )
            )
        }
    }
}
