#if os(macOS)
enum SetDeckConfigId: AnkiAction {
    static let name = "setDeckConfigId"
    static let version = 6

    struct Params: Encodable {
        let decks: [String]
        let configId: DeckConfigID
    }

    typealias Result = Bool
}


extension Anki {
    public func setDeckConfigId(decks: [String], configId: DeckConfigID) async throws -> Bool {
        try await perform(SetDeckConfigId.self, params: .init(decks: decks, configId: configId))
    }
}
#endif
