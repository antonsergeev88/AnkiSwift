enum ForgetCards: AnkiAction {
    static let name = "forgetCards"
    static let version = 6

    struct Params: Encodable {
        let cards: [CardID]
    }

    typealias Result = ForgetCardsResult
}

public struct ForgetCardsResult: Decodable {}

extension Anki {
    public func forgetCards(cards: [CardID]) async throws -> ForgetCardsResult {
        try await perform(ForgetCards.self, params: .init(cards: cards))
    }
}
