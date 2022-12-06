#if os(macOS)
enum DeleteDecks: AnkiAction {
    static let name = "deleteDecks"
    static let version = 6

    struct Params: Encodable {
        let decks: [String]
        let cardsToo = true
    }

    typealias Result = DeleteDecksResult
}

public struct DeleteDecksResult: Decodable {}

extension Anki {
    public func deleteDecks(decks: [String]) async throws -> DeleteDecksResult {
        try await perform(DeleteDecks.self, params: .init(decks: decks))
    }
}
#endif
