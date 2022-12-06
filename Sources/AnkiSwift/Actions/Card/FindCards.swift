#if os(macOS)
enum FindCards: AnkiAction {
    static let name = "findCards"
    static let version = 6

    struct Params: Encodable {
        let query: String
    }

    typealias Result = [CardID]
}

extension Anki {
    public func findCards(query: String) async throws -> [CardID] {
        try await perform(FindCards.self, params: .init(query: query))
    }
}
#endif
