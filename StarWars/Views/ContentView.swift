import SwiftUI

struct ContentView: View {

    private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            ListView(viewModel: viewModel)
                .navigationTitle(Constants.title)
        }
        .searchable(text: viewModel.searchBinding)
    }

}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView(
            viewModel: ViewModel(
                searchClient: SearchClient(),
                peopleClient: PeopleClient()
            )
        )
    }
}
