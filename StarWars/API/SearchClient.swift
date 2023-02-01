import Combine
import Foundation

struct SearchClient {

    func searchAll(for query: String) async throws -> [any Resource] {
        let people: [any Resource] = try await searchPeople(for: query)
        let planets: [any Resource] = try await searchPlanets(for: query)
        let films: [any Resource] = try await searchFilms(for: query)
        let species: [any Resource] = try await searchSpecies(for: query)
        let vehicles: [any Resource] = try await searchVehicles(for: query)
        let starships: [any Resource] = try await searchStarships(for: query)

        return people + planets + films + species + vehicles + starships
    }

    func searchPeople(for query: String) async throws -> [Resources.Person] {
        try await search(.people, for: query)
    }

    func searchPlanets(for query: String) async throws -> [Resources.Planet] {
        try await search(.planets, for: query)
    }

    func searchFilms(for query: String) async throws -> [Resources.Film] {
        try await search(.films, for: query)
    }

    func searchSpecies(for query: String) async throws -> [Resources.Species] {
        try await search(.species, for: query)
    }

    func searchVehicles(for query: String) async throws -> [Resources.Vehicle] {
        try await search(.vehicles, for: query)
    }

    func searchStarships(for query: String) async throws -> [Resources.Starship] {
        try await search(.starships, for: query)
    }

    private func search<T: Decodable>(
        _ resourceType: Resources.ResourceType,
        for query: String,
        decoding _: T.Type = T.self
    ) async throws -> [T] {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .alphanumerics),
              let url = URL(string: "\(resourceType.baseURL)?search=\(query)") else {
            throw Error.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(Response<T>.self, from: data)
        return response.results
    }

}

extension SearchClient {

    struct Response<T: Decodable>: Decodable {

        let count: Int
        let next: URL?
        let results: [T]

    }

    enum Error: LocalizedError {
        case invalidURL
    }

}

extension Resources.ResourceType {

    var baseURL: String {
        switch self {
            case .people: return "https://swapi.dev/api/people/"
            case .planets: return "https://swapi.dev/api/planets/"
            case .films: return "https://swapi.dev/api/films/"
            case .species: return "https://swapi.dev/api/species/"
            case .vehicles: return "https://swapi.dev/api/vehicles/"
            case .starships: return "https://swapi.dev/api/starships/"
        }
    }

}
