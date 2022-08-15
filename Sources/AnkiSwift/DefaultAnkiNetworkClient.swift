import Foundation

public class DefaultAnkiNetworkClient: AnkiNetworkClient {
    let urlSession: URLSession

    public init() {
        urlSession = .shared
    }

    public func ankiRequest(body: Data) async throws -> Data {
        let url = URL(string: "http://localhost:8765")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        return try await urlSession.data(for: request).0
    }
}
