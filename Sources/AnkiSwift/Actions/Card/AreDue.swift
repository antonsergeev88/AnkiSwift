enum AreDue: AnkiAction {
    static let name = "areDue"
    static let version = 6

    struct Params: Encodable {
        let cards: [CardID]
    }

    typealias Result = [Bool]
}

extension Anki {
    public func areDue(cards: [CardID]) async throws -> [Bool] {
        try await networkClient.perform(AreDue.self, params: .init(cards: cards))
    }
}
