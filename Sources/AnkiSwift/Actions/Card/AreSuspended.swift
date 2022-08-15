enum AreSuspended: AnkiAction {
    static let name = "areSuspended"
    static let version = 6

    struct Params: Encodable {
        let cards: [CardID]
    }

    typealias Result = [Bool?]
}

extension Anki {
    public func areSuspended(cards: [CardID]) async throws -> [Bool?] {
        try await networkClient.perform(AreSuspended.self, params: .init(cards: cards))
    }
}
