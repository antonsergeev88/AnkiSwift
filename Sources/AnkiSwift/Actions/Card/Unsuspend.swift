enum Unsuspend: AnkiAction {
    static let name = "unsuspend"
    static let version = 6

    struct Params: Encodable {
        let cards: [CardID]
    }

    typealias Result = Bool
}

extension Anki {
    public func unsuspend(cards: [CardID]) async throws -> Bool {
        try await perform(Unsuspend.self, params: .init(cards: cards))
    }
}
