enum GetEaseFactors: AnkiAction {
    static let name = "getEaseFactors"
    static let version = 6

    struct Params: Encodable {
        let cards: [CardID]
    }
    
    typealias Result = [EaseFactor]
}

extension Anki {
    public func getEaseFactors(cards: [CardID]) async throws -> [EaseFactor] {
        try await networkClient.perform(GetEaseFactors.self, params: .init(cards: cards))
    }
}
