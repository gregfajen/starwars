import Combine
import Foundation

extension ViewModel {

    /// a wrapper for `Resource` that maintains state for loading people
    class Item: Identifiable, ObservableObject, Equatable {

        let resource: any Resource
        var people: [Resources.Person]
        var isLoadingPeople = false
        var errorOccurred = false

        /// `ObservableObject` compliance
        public let objectWillChange = ObservableObjectPublisher()

        init(resource: any Resource) {
            self.resource = resource
            people = []
        }

        var name: String { resource.name }
        var id: URL { resource.url }
        var type: Resources.ResourceType { resource.type }

        /// asynchronously loads and caches the `Person`s associated with this item
        func loadPeopleIfNeeded(using client: PeopleClient) {
            guard !isLoadingPeople,
                  people.isEmpty,
                  !resource.peopleURLs.isEmpty else {
                return
            }

            objectWillChange.send()
            isLoadingPeople = true

            Task { [objectWillChange] in
                do {
                    people = try await client.fetchPeople(at: resource.peopleURLs)
                    errorOccurred = false
                } catch {
                    errorOccurred = true
                }

                isLoadingPeople = false

                DispatchQueue.main.async {
                    objectWillChange.send()
                }
            }
        }

        static func == (lhs: ViewModel.Item, rhs: ViewModel.Item) -> Bool {
            lhs.id == rhs.id
        }

    }

}
