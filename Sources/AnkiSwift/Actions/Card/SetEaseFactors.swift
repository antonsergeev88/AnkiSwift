enum SetEaseFactors: AnkiAction {
    static let name = "setEaseFactors"
    static let version = 6

    struct Params: Encodable {
        let cards: [CardID]
        let easeFactors: [EaseFactor]
    }

    typealias Result = [Bool]
}

extension Anki {
    public func setEaseFactors(cards: [CardID], easeFactors: [EaseFactor]) async throws -> [Bool] {
        try await networkClient.perform(SetEaseFactors.self, params: .init(cards: cards, easeFactors: easeFactors))
    }
}
