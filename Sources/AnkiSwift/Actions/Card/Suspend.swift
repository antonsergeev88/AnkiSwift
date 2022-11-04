#if os(macOS)
enum Suspend: AnkiAction {
    static let name = "suspend"
    static let version = 6

    struct Params: Encodable {
        let cards: [CardID]
    }

    typealias Result = Bool
}

extension Anki {
    public func suspend(cards: [CardID]) async throws -> Bool {
        try await perform(Suspend.self, params: .init(cards: cards))
    }
}
#endif
