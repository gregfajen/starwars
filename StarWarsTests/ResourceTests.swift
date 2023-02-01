@testable import StarWars
import XCTest

final class ResourceTests: XCTestCase {

    func decode<T: Decodable>(_ payload: String, type: T.Type = T.self) throws -> T {
        let data = payload.data(using: .utf8)!
        let result = try JSONDecoder().decode(type, from: data)
        return result
    }

    func testPersonParsing() throws {
        let payload = """
        {
            "name": "Luke Skywalker",
            "height": "172",
            "mass": "77",
            "hair_color": "blond",
            "skin_color": "fair",
            "eye_color": "blue",
            "birth_year": "19BBY",
            "gender": "male",
            "homeworld": "https://swapi.dev/api/planets/1/",
            "films": [
                "https://swapi.dev/api/films/2/",
                "https://swapi.dev/api/films/6/",
                "https://swapi.dev/api/films/3/",
                "https://swapi.dev/api/films/1/",
                "https://swapi.dev/api/films/7/"
            ],
            "species": [
                "https://swapi.dev/api/species/1/"
            ],
            "vehicles": [
                "https://swapi.dev/api/vehicles/14/",
                "https://swapi.dev/api/vehicles/30/"
            ],
            "starships": [
                "https://swapi.dev/api/starships/12/",
                "https://swapi.dev/api/starships/22/"
            ],
            "created": "2014-12-09T13:50:51.644000Z",
            "edited": "2014-12-20T21:17:56.891000Z",
            "url": "https://swapi.dev/api/people/1/"
        }
        """

        let result: Resources.Person = try decode(payload)
        XCTAssert(result.name == "Luke Skywalker")
    }

    func testPlanetParsing() throws {
        let payload = """
        {
            "name": "Tatooine",
            "rotation_period": "23",
            "orbital_period": "304",
            "diameter": "10465",
            "climate": "arid",
            "gravity": "1 standard",
            "terrain": "desert",
            "surface_water": "1",
            "population": "200000",
            "residents": [
                "https://swapi.dev/api/people/1/",
                "https://swapi.dev/api/people/2/",
                "https://swapi.dev/api/people/4/",
                "https://swapi.dev/api/people/6/",
                "https://swapi.dev/api/people/7/",
                "https://swapi.dev/api/people/8/",
                "https://swapi.dev/api/people/9/",
                "https://swapi.dev/api/people/11/",
                "https://swapi.dev/api/people/43/",
                "https://swapi.dev/api/people/62/"
            ],
            "films": [
                "https://swapi.dev/api/films/1/",
                "https://swapi.dev/api/films/3/",
                "https://swapi.dev/api/films/4/",
                "https://swapi.dev/api/films/5/",
                "https://swapi.dev/api/films/6/"
            ],
            "created": "2014-12-09T13:50:49.641000Z",
            "edited": "2014-12-20T20:58:18.411000Z",
            "url": "https://swapi.dev/api/planets/1/"
        }
        """

        let result: Resources.Planet = try decode(payload)
        XCTAssert(result.name == "Tatooine")
    }

    func testFilmParsing() throws {
        let payload = """
        {
            "title": "A New Hope",
            "episode_id": 4,
            "opening_crawl": "It is a period of civil war.\\r\\nRebel spaceships, striking\\r\\nfrom a hidden base, have won\\r\\ntheir first victory against\\r\\nthe evil Galactic Empire.\\r\\n\\r\\nDuring the battle, Rebel\\r\\nspies managed to steal secret\\r\\nplans to the Empire's\\r\\nultimate weapon, the DEATH\\r\\nSTAR, an armored space\\r\\nstation with enough power\\r\\nto destroy an entire planet.\\r\\n\\r\\nPursued by the Empire's\\r\\nsinister agents, Princess\\r\\nLeia races home aboard her\\r\\nstarship, custodian of the\\r\\nstolen plans that can save her\\r\\npeople and restore\\r\\nfreedom to the galaxy....",
            "director": "George Lucas",
            "producer": "Gary Kurtz, Rick McCallum",
            "release_date": "1977-05-25",
            "characters": [
                "https://swapi.dev/api/people/1/",
                "https://swapi.dev/api/people/2/",
                "https://swapi.dev/api/people/3/",
                "https://swapi.dev/api/people/4/",
                "https://swapi.dev/api/people/5/",
                "https://swapi.dev/api/people/6/",
                "https://swapi.dev/api/people/7/",
                "https://swapi.dev/api/people/8/",
                "https://swapi.dev/api/people/9/",
                "https://swapi.dev/api/people/10/",
                "https://swapi.dev/api/people/12/",
                "https://swapi.dev/api/people/13/",
                "https://swapi.dev/api/people/14/",
                "https://swapi.dev/api/people/15/",
                "https://swapi.dev/api/people/16/",
                "https://swapi.dev/api/people/18/",
                "https://swapi.dev/api/people/19/",
                "https://swapi.dev/api/people/81/"
            ],
            "planets": [
                "https://swapi.dev/api/planets/1/",
                "https://swapi.dev/api/planets/2/",
                "https://swapi.dev/api/planets/3/"
            ],
            "starships": [
                "https://swapi.dev/api/starships/2/",
                "https://swapi.dev/api/starships/3/",
                "https://swapi.dev/api/starships/5/",
                "https://swapi.dev/api/starships/9/",
                "https://swapi.dev/api/starships/10/",
                "https://swapi.dev/api/starships/11/",
                "https://swapi.dev/api/starships/12/",
                "https://swapi.dev/api/starships/13/"
            ],
            "vehicles": [
                "https://swapi.dev/api/vehicles/4/",
                "https://swapi.dev/api/vehicles/6/",
                "https://swapi.dev/api/vehicles/7/",
                "https://swapi.dev/api/vehicles/8/"
            ],
            "species": [
                "https://swapi.dev/api/species/1/",
                "https://swapi.dev/api/species/2/",
                "https://swapi.dev/api/species/3/",
                "https://swapi.dev/api/species/4/",
                "https://swapi.dev/api/species/5/"
            ],
            "created": "2014-12-10T14:23:31.880000Z",
            "edited": "2014-12-20T19:49:45.256000Z",
            "url": "https://swapi.dev/api/films/1/"
        }
        """

        let result: Resources.Film = try decode(payload)
        XCTAssert(result.title == "A New Hope")
    }

    func testSpeciesParsing() throws {
        let payload = """
        {
            "name": "Human",
            "classification": "mammal",
            "designation": "sentient",
            "average_height": "180",
            "skin_colors": "caucasian, black, asian, hispanic",
            "hair_colors": "blonde, brown, black, red",
            "eye_colors": "brown, blue, green, hazel, grey, amber",
            "average_lifespan": "120",
            "homeworld": "https://swapi.dev/api/planets/9/",
            "language": "Galactic Basic",
            "people": [
                "https://swapi.dev/api/people/66/",
                "https://swapi.dev/api/people/67/",
                "https://swapi.dev/api/people/68/",
                "https://swapi.dev/api/people/74/"
            ],
            "films": [
                "https://swapi.dev/api/films/1/",
                "https://swapi.dev/api/films/2/",
                "https://swapi.dev/api/films/3/",
                "https://swapi.dev/api/films/4/",
                "https://swapi.dev/api/films/5/",
                "https://swapi.dev/api/films/6/"
            ],
            "created": "2014-12-10T13:52:11.567000Z",
            "edited": "2014-12-20T21:36:42.136000Z",
            "url": "https://swapi.dev/api/species/1/"
        }
        """

        let result: Resources.Species = try decode(payload)
        XCTAssert(result.name == "Human")
    }

    func testVehicleParsing() throws {
        let payload = """
        {
            "name": "Snowspeeder",
            "model": "t-47 airspeeder",
            "manufacturer": "Incom corporation",
            "cost_in_credits": "unknown",
            "length": "4.5",
            "max_atmosphering_speed": "650",
            "crew": "2",
            "passengers": "0",
            "cargo_capacity": "10",
            "consumables": "none",
            "vehicle_class": "airspeeder",
            "pilots": [
                "https://swapi.dev/api/people/1/",
                "https://swapi.dev/api/people/18/"
            ],
            "films": [
                "https://swapi.dev/api/films/2/"
            ],
            "created": "2014-12-15T12:22:12Z",
            "edited": "2014-12-20T21:30:21.672000Z",
            "url": "https://swapi.dev/api/vehicles/14/"
        }
        """

        let result: Resources.Vehicle = try decode(payload)
        XCTAssert(result.name == "Snowspeeder")
    }

    func testStarshipParsing() throws {
        let payload = """
        {
            "name": "X-wing",
            "model": "T-65 X-wing",
            "manufacturer": "Incom Corporation",
            "cost_in_credits": "149999",
            "length": "12.5",
            "max_atmosphering_speed": "1050",
            "crew": "1",
            "passengers": "0",
            "cargo_capacity": "110",
            "consumables": "1 week",
            "hyperdrive_rating": "1.0",
            "MGLT": "100",
            "starship_class": "Starfighter",
            "pilots": [
                "https://swapi.dev/api/people/1/",
                "https://swapi.dev/api/people/9/",
                "https://swapi.dev/api/people/18/",
                "https://swapi.dev/api/people/19/"
            ],
            "films": [
                "https://swapi.dev/api/films/1/",
                "https://swapi.dev/api/films/2/",
                "https://swapi.dev/api/films/3/"
            ],
            "created": "2014-12-12T11:19:05.340000Z",
            "edited": "2014-12-20T21:23:49.886000Z",
            "url": "https://swapi.dev/api/starships/12/"
        }
        """

        let result: Resources.Starship = try decode(payload)
        XCTAssert(result.name == "X-wing")
    }

    func testResponseParsing() throws {
        let payload = """
        {
            "count": 1,
            "next": null,
            "previous": null,
            "results": [
                {
                    "name": "Luke Skywalker",
                    "height": "172",
                    "mass": "77",
                    "hair_color": "blond",
                    "skin_color": "fair",
                    "eye_color": "blue",
                    "birth_year": "19BBY",
                    "gender": "male",
                    "homeworld": "https://swapi.dev/api/planets/1/",
                    "films": [
                        "https://swapi.dev/api/films/1/",
                        "https://swapi.dev/api/films/2/",
                        "https://swapi.dev/api/films/3/",
                        "https://swapi.dev/api/films/6/"
                    ],
                    "species": [],
                    "vehicles": [
                        "https://swapi.dev/api/vehicles/14/",
                        "https://swapi.dev/api/vehicles/30/"
                    ],
                    "starships": [
                        "https://swapi.dev/api/starships/12/",
                        "https://swapi.dev/api/starships/22/"
                    ],
                    "created": "2014-12-09T13:50:51.644000Z",
                    "edited": "2014-12-20T21:17:56.891000Z",
                    "url": "https://swapi.dev/api/people/1/"
                }
            ]
        }
        """

        let result: SearchClient.Response<Resources.Person> = try decode(payload)
        XCTAssert(result.count == 1)
        XCTAssert(result.results.first?.name == "Luke Skywalker")
    }

}
