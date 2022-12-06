#if os(macOS)
enum DeckNamesAndIds: AnkiAction {
    static let name = "deckNamesAndIds"
    static let version = 6

    struct Params: Encodable {}

    typealias Result = [String: Int]
}

extension Anki {
    public func deckNamesAndIds() async throws -> [String: Int] {
        try await perform(DeckNamesAndIds.self, params: .init())
    }
}
#endif
