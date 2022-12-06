#if os(macOS)
enum GetDecks: AnkiAction {
    static let name = "getDecks"
    static let version = 6

    struct Params: Encodable {
        let cards: [CardID]
    }

    typealias Result = [String: [Int]]
}

extension Anki {
    public func getDecks(cards: [CardID]) async throws -> [String: [Int]] {
        try await perform(GetDecks.self, params: .init(cards: cards))
    }
}
#endif
