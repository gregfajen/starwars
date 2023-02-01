import Foundation

extension String {

    var folded: String {
        folding(options: [.caseInsensitive, .diacriticInsensitive, .widthInsensitive], locale: nil)
    }

    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

}
