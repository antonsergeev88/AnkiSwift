#if os(macOS)
enum RelearnCards: AnkiAction {
    static let name = "relearnCards"
    static let version = 6

    struct Params: Encodable {
        let cards: [CardID]
    }

    typealias Result = RelearnCardsResult
}

public struct RelearnCardsResult: Decodable {}

extension Anki {
    public func relearnCards(cards: [CardID]) async throws -> RelearnCardsResult {
        try await perform(RelearnCards.self, params: .init(cards: cards))
    }
}
#endif
