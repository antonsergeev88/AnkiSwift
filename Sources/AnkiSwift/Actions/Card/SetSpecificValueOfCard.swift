enum SetSpecificValueOfCard: AnkiAction {
    static let name = "setSpecificValueOfCard"
    static let version = 6

    struct Params: Encodable {
        let card: CardID
        let keys: [String]
        let newValues: [String]
        let warning_check: Bool
    }

    typealias Result = [Bool]
}

extension Anki {
    public func setSpecificValueOfCard(card: CardID, values: [CardValue], warningCheck: Bool = false) async throws -> [Bool] {
        try await networkClient.perform(SetSpecificValueOfCard.self, params: .init(card: card, keys: values.map(\.key), newValues: values.map(\.value), warning_check: warningCheck))
    }
}
