import AnkiSwift
import Foundation

struct CheckRequestError: Error {}

class NetworkClient: AnkiNetworkClient {
    var request = Data()
    var response = String()

    func ankiRequest(body: Data) async throws -> Data {
        request = body
        return response.data(using: .utf8)!
    }

    func checkRequest(_ testRequestString: String) throws {
        let testRequest = testRequestString.data(using: .utf8)!
        let json = try JSONSerialization.jsonObject(with: request) as! NSDictionary
        let testJSON = try JSONSerialization.jsonObject(with: testRequest) as! NSDictionary
        guard json.isEqual(to: testJSON) else {
            throw CheckRequestError()
        }
    }
}
