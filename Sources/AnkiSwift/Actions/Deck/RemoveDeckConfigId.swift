enum RemoveDeckConfigId: AnkiAction {
    static let name = "removeDeckConfigId"
    static let version = 6

    struct Params: Encodable {
        let configId: DeckConfigID
    }

    typealias Result = Bool
}


extension Anki {
    public func removeDeckConfigId(configId: DeckConfigID) async throws -> Bool {
        try await perform(RemoveDeckConfigId.self, params: .init(configId: configId))
    }
}
