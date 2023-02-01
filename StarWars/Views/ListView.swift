import Foundation
import SwiftUI

struct ListView: View {

    typealias Item = ViewModel.Item

    enum ListState: Equatable {
        case emptyQuery
        case emptyResults
        case error
        case loading
        case items([Item])
    }

    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var state: ListState {
        viewModel.listState
    }

    var items: [Item] {
        if case let .items(items) = state {
            return items
        } else {
            return []
        }
    }

    var body: some View {
        switch state {
            case .emptyQuery:
                Text(Constants.searchForSomething)
                    .font(.callout)
                    .foregroundColor(.primary)
                    .opacity(0.5)

            case .emptyResults:
                Text(Constants.noResults)
                    .font(.callout)
                    .foregroundColor(.primary)

            case .error:
                Text(Constants.somethingWentWrong)
                    .font(.callout)
                    .foregroundColor(.red)

            case .loading:
                ProgressView()

            case let .items(items):
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(items) { item in
                            ResourceView(item: item)
                        }
                    }
                    .padding(20)
                }
        }
    }

}
