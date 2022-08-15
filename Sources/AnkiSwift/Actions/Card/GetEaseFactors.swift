enum GetEaseFactors: AnkiAction {
    static let name = "getEaseFactors"
    static let version = 6

    struct Params: Encodable {
        let cards: [CardID]
    }
    
    typealias Result = [EaseFactor]
}
