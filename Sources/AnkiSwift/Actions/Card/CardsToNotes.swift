#if os(macOS)
enum CardsToNotes: AnkiAction {
    static let name = "cardsToNotes"
    static let version = 6

    struct Params: Encodable {
        let cards: [CardID]
    }

    typealias Result = [NoteID]
}

extension Anki {
    public func cardsToNotes(cards: [CardID]) async throws -> [NoteID] {
        try await perform(CardsToNotes.self, params: .init(cards: cards))
    }
}
#endif
