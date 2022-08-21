import Foundation

public protocol AnkiNetworkClient {
    func ankiRequest(body: Data) async throws -> Data
}

let encoder = JSONEncoder()
let decoder = JSONDecoder()

extension AnkiNetworkClient {
    func perform<Action: AnkiAction>(_: Action.Type, params: Action.Params) async throws -> Action.Result {
        let body = ActionBody<Action>(params)
        let encodedBody = try encoder.encode(body)
        let response = try await ankiRequest(body: encodedBody)
        guard let jsonObject = try? JSONSerialization.jsonObject(with: response) as? [String: NSObject] else {
            throw ResponseError(message: "Unexpected response from anki-connect")
        }
        if let responseError = jsonObject["error"], responseError != NSNull()  {
            let error = try decoder.decode(ActionErrorEnvelop.self, from: response).error
            throw ResponseError(message: error)
        } else {
            return try decoder.decode(ActionResultEnvelop<Action.Result>.self, from: response).result
        }
    }
}


struct ResponseError: Error {
    let message: String
}

struct ActionBody<Action: AnkiAction>: Encodable {
    let action = Action.name
    let version = Action.version
    let params: Action.Params

    init(_ params: Action.Params) {
        self.params = params
    }
}

struct ActionResultEnvelop<Result: Decodable>: Decodable {
    let result: Result
}

struct ActionErrorEnvelop: Decodable {
    let error: String
}

