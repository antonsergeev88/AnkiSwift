enum DeckNames: AnkiAction {
    static let name = "deckNames"
    static let version = 6

    struct Params: Encodable {}

    typealias Result = [String]
}

extension Anki {
    public func deckNames() async throws -> [String] {
        try await perform(DeckNames.self, params: .init())
    }
}
