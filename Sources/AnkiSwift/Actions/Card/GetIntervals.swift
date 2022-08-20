enum GetIntervals {}

extension GetIntervals {
    enum Incomplete: AnkiAction {
        static let name = "getIntervals"
        static let version = 6

        struct Params: Encodable {
            let cards: [CardID]
        }

        typealias Result = [Interval]
    }
}

extension Anki {
    public func getIntervals(cards: [CardID]) async throws -> [Interval] {
        try await perform(GetIntervals.Incomplete.self, params: .init(cards: cards))
    }
}

extension GetIntervals {
    enum Complete: AnkiAction {
        static let name = "getIntervals"
        static let version = 6

        struct Params: Encodable {
            let cards: [CardID]
            let complete = true
        }

        typealias Result = [[Interval]]
    }
}

extension Anki {
    public func getIntervalsComplete(cards: [CardID]) async throws -> [[Interval]] {
        try await perform(GetIntervals.Complete.self, params: .init(cards: cards))
    }
}
