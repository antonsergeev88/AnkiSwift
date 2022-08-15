import Foundation

public class Anki {
    let networkClient: AnkiNetworkClient

    public init(networkClient: AnkiNetworkClient = DefaultAnkiNetworkClient()) {
        self.networkClient = networkClient
    }
}
