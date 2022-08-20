enum CardsInfo: AnkiAction {
    static let name = "cardsInfo"
    static let version = 6

    struct Params: Encodable {
        let cards: [CardID]
    }

    typealias Result = [CardsInfoResult]
}

public struct CardsInfoResult: Codable {
    public let cardId: CardID
    public let fields: [String: Field]
    public let fieldOrder: Int
    public let question: String
    public let answer: String
    public let modelName: String
    public let ord: Int
    public let deckName: String
    public let css: String
    public let factor: Int
    public let interval: Int
    public let note: NoteID
    public let type: Int
    public let queue: Int
    public let due: Int
    public let reps: Int
    public let lapses: Int
    public let left: Int
    public let mod: Int
}

extension CardsInfoResult {
    public struct Field: Codable {
        public let value: String
        public let order: Int
    }
}

extension Anki {
    public func cardsInfo(cards: [CardID]) async throws -> [CardsInfoResult] {
        try await perform(CardsInfo.self, params: .init(cards: cards))
    }
}
