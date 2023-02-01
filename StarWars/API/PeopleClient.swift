import Foundation

@MainActor
class PeopleClient {

    private var people: [URL: Resources.Person]

    init() {
        people = [:]
    }

    func fetchPerson(at url: URL) async throws -> Resources.Person {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Resources.Person.self, from: data)
    }

    func fetchPeople(at urls: [URL]) async throws -> [Resources.Person] {
        try await withThrowingTaskGroup(of: Resources.Person.self) { group in
            for url in urls {
                group.addTask {
                    try await self.fetchPerson(at: url)
                }
            }

            var result = [Resources.Person]()
            for try await person in group {
                result.append(person)
            }
            return result
        }
    }

}
