import Foundation
import SwiftUI

struct ResourceView: View {

    @ObservedObject private var item: ViewModel.Item

    init(item: ViewModel.Item) {
        self.item = item
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            people
        }
        .background(Color.lightGray)
        .cornerRadius(10)

    }

    @ViewBuilder
    var header: some View {
        HStack {
            Text(item.name)
                .font(.system(.headline))

            Spacer()

            ResourceTypeView(resourceType: item.type)
        }
        .frame(height: 40)
        .padding(10)
    }

    @ViewBuilder
    var people: some View {
        if item.isLoadingPeople {
            ZStack {
                ProgressView()
                    .padding(20)
                    .frame(maxWidth: .infinity)
            }
        } else if !item.people.isEmpty {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(item.people) { person in
                    PersonView(person: person)
                }
            }
            .padding(10)
        } else if item.errorOccurred {
            Text(Constants.somethingWentWrong)
                .font(.subheadline)
                .foregroundColor(.red)
                .padding(10)
        }
    }

}

struct ResourceTypeView: View {

    let resourceType: Resources.ResourceType

    var text: String {
        switch resourceType {
            case .people: return "PERSON"
            case .planets: return "PLANET"
            case .films: return "FILM"
            case .species: return "SPECIES"
            case .vehicles: return "VEHICLE"
            case .starships: return "STARSHIP"
        }
    }

    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.system(.caption2))
            .padding(8)
            .background(.primary)
            .cornerRadius(.greatestFiniteMagnitude)
    }

}

struct PersonView: View {

    let person: Resources.Person

    var body: some View {
        Text(person.name)
            .font(.system(.body))
            .frame(height: 40)
    }

}

struct ResourceViewPreviews: PreviewProvider {

    static func makeItem() -> ViewModel.Item {
        let client = PeopleClient()
        let resource = Resources.Person(
            name: "Luke Skywalker",
            url: URL(string: "https://swapi.dev/api/people/1/")!
        )
        let item = ViewModel.Item(resource: resource)
        item.loadPeopleIfNeeded(using: client)
        return item
    }

    static var previews: some View {
        ResourceView(item: makeItem())
    }

}
