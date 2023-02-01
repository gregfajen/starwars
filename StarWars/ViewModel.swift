import Combine
import Foundation
import SwiftUI

@MainActor
class ViewModel: ObservableObject {

    /// a publisher that keeps track of our query
    private let querySubject = CurrentValueSubject<String, Never>("")
    var query: String { querySubject.value }

    /// a cache of `Item`s
    private var items: [URL: Item] = [:]

    /// the state of the list
    var listState: ListView.ListState = .emptyQuery

    let searchClient: SearchClient
    let peopleClient: PeopleClient

    /// `ObservableObject` compliance
    public let objectWillChange = ObservableObjectPublisher()

    /// to keep track of subscriptions
    private var subscriptions = Set<AnyCancellable>()

    init(
        searchClient: SearchClient,
        peopleClient: PeopleClient
    ) {
        self.searchClient = searchClient
        self.peopleClient = peopleClient
        subscribeToSearchUpdates()
    }

    convenience init() {
        self.init(
            searchClient: SearchClient(),
            peopleClient: PeopleClient()
        )
    }

    /// a `Binding` to be used to bind the search bar to the view model
    /// holds a strong reference to the view model
    var searchBinding: Binding<String> {
        Binding<String> {
            self.query
        } set: { newValue, _ in
            self.querySubject.send(newValue)
        }
    }

    /// sets up our publishers so we can update the UI
    private func subscribeToSearchUpdates() {
        makeListStatePublisher()
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                print("state: \(state)")
                self?.objectWillChange.send()
                self?.listState = state
            }
            .store(in: &subscriptions)
    }

    /// makes a publisher that trims and debounces query strings
    private func makeQueryPublisher() -> AnyPublisher<String, Never> {
        querySubject
            .map(\.trimmed.folded)
            .removeDuplicates()
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }

    /// makes a publisher that returns updated `ListState`s
    private func makeListStatePublisher() -> AnyPublisher<ListView.ListState, Never> {
        makeQueryPublisher()
            .map { self.listState(for: $0) }
            .switchToLatest()
            .eraseToAnyPublisher()

    }

    /// queries the API, returning an appropriate `ListState`
    private func listState(for query: String) -> AnyPublisher<ListView.ListState, Never> {
        guard query.count > 1 else {
            return Just(.emptyQuery).eraseToAnyPublisher()
        }

        let publisher = CurrentValueSubject<ListView.ListState, Never>(.loading)

        Task {
            do {
                let items = try await search(for: query)
                if items.isEmpty {
                    publisher.send(.emptyResults)
                } else {
                    publisher.send(.items(items))
                }
            } catch {
                publisher.send(.error)
            }
        }

        return publisher.eraseToAnyPublisher()
    }

    /// queries the API, returning an array of `Item`s or throwing an error
    private func search(for query: String) async throws -> [Item] {
        let resources = try await searchClient.searchAll(for: query)
        return items(for: resources)
    }

    /// returns a corresponding `Item` for a `Resource`
    private func item(for resource: any Resource) -> Item {
        if let item = items[resource.id] {
            item.loadPeopleIfNeeded(using: peopleClient)
            return item
        } else {
            let item = Item(resource: resource)
            item.loadPeopleIfNeeded(using: peopleClient)
            items[resource.id] = item
            return item
        }
    }

    /// returns corresponding `Item`s for an array of `Resource`s
    private func items(for resources: [any Resource]) -> [Item] {
        resources.map { item(for: $0) }
    }

}
