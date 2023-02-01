import Foundation

protocol Resource: Codable, Identifiable {

    var name: String { get }
    var url: URL { get }
    var type: Resources.ResourceType { get }
    var peopleURLs: [URL] { get }

}

extension Resource {

    var id: URL { url }

}

enum Resources {

    enum ResourceType: String {
        case people, planets, films, species, vehicles, starships
    }

    struct Person: Resource {

        let name: String
        let url: URL

        var type: ResourceType { .people }
        var peopleURLs: [URL] { [] }

    }

    struct Planet: Resource {

        let name: String
        let url: URL
        let residents: [URL]

        var type: ResourceType { .planets }
        var peopleURLs: [URL] { residents }

    }

    struct Film: Resource {

        let title: String
        let url: URL
        let characters: [URL]

        var name: String { title }
        var type: ResourceType { .films }
        var peopleURLs: [URL] { characters }

    }

    struct Species: Resource {

        let name: String
        let url: URL
        let people: [URL]

        var type: ResourceType { .species }
        var peopleURLs: [URL] { people }

    }

    struct Vehicle: Resource {

        let name: String
        let model: String
        let url: URL
        let pilots: [URL]

        var type: ResourceType { .vehicles }
        var peopleURLs: [URL] { pilots }

    }

    struct Starship: Resource {

        let name: String
        let model: String
        let url: URL
        let pilots: [URL]

        var type: ResourceType { .vehicles }
        var peopleURLs: [URL] { pilots }

    }

}
