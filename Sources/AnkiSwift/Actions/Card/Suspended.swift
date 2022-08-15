enum Suspended: AnkiAction {
    static let name = "suspended"
    static let version = 6

    struct Params: Encodable {
        let card: CardID
    }

    typealias Result = Bool
}

extension Anki {
    public func suspended(card: CardID) async throws -> Bool {
        try await networkClient.perform(Suspended.self, params: .init(card: card))
    }
}
