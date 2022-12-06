#if os(macOS)
enum CloneDeckConfigId: AnkiAction {
    static let name = "cloneDeckConfigId"
    static let version = 6

    struct Params: Encodable {
        let name: String
        let cloneFrom: DeckConfigID
    }

    typealias Result = DeckConfigID
}


extension Anki {
    public func cloneDeckConfigId(name: String, cloneFrom deckId: DeckConfigID) async throws -> DeckConfigID {
        try await perform(CloneDeckConfigId.self, params: .init(name: name, cloneFrom: deckId))
    }
}
#endif
