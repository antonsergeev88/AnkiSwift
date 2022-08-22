enum CreateDeck: AnkiAction {
    static let name = "createDeck"
    static let version = 6

    struct Params: Encodable {
        let deck: String
    }

    typealias Result = DeckID
}

extension Anki {
    public func createDeck(deck: String) async throws -> DeckID {
        try await perform(CreateDeck.self, params: .init(deck: deck))
    }
}
