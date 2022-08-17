enum CardsModTime: AnkiAction {
    static let name = "cardsModTime"
    static let version = 6

    struct Params: Encodable {
        let cards: [CardID]
    }

    typealias Result = [CardsModTimeResult]
}

public struct CardsModTimeResult: Codable {
    public let cardId: CardID
    public let mod: Int
}

extension Anki {
    public func cardsModTime(cards: [CardID]) async throws -> [CardsModTimeResult] {
        try await networkClient.perform(CardsModTime.self, params: .init(cards: cards))
    }
}
