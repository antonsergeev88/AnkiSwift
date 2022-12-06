#if os(macOS)
import Foundation

public class Anki {
    private let networkClient: AnkiNetworkClient

    public init(networkClient: AnkiNetworkClient = DefaultAnkiNetworkClient()) {
        self.networkClient = networkClient
    }

    func perform<Action: AnkiAction>(_: Action.Type, params: Action.Params) async throws -> Action.Result {
        try await networkClient.perform(Action.self, params: params)
    }
}
#endif
