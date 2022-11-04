#if os(macOS)
enum ChangeDeck: AnkiAction {
    static let name = "changeDeck"
    static let version = 6

    struct Params: Encodable {
        let cards: [CardID]
        let deck: String
    }

    typealias Result = ChangeDeckResult
}

public struct ChangeDeckResult: Decodable {}

extension Anki {
    public func changeDeck(cards: [CardID], deck: String) async throws -> ChangeDeckResult {
        try await perform(ChangeDeck.self, params: .init(cards: cards, deck: deck))
    }
}
#endif
