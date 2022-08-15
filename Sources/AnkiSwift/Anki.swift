import Foundation

public class Anki {
    private let networkClient: AnkiNetworkClient

    public init(networkClient: AnkiNetworkClient = DefaultAnkiNetworkClient()) {
        self.networkClient = networkClient
    }

    public func getEaseFactors(cards: [CardID]) async throws -> [EaseFactor] {
        try await networkClient.perform(GetEaseFactors.self, params: .init(cards: cards))
    }
}
