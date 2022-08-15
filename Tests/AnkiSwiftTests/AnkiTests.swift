import XCTest
@testable import AnkiSwift

final class AnkiTests: XCTestCase {
    var anki: Anki = Anki(networkClient: NetworkClient())
    var networkClient = NetworkClient()

    override func setUp() {
        super.setUp()
        networkClient = NetworkClient()
        anki = Anki(networkClient: networkClient)
    }

    // MARK: - Errors

    func testError() async {
        let response = """
            {
                "result": null,
                "error": "Something goes wrong"
            }
            """
        networkClient.response = response
        do {
            _ = try await anki.getEaseFactors(cards: [1])
            XCTFail()
        } catch {}
    }

    func testEmptyResponse() async {
        let response = """
            {
                "result": null,
                "error": null
            }
            """
        networkClient.response = response
        do {
            _ = try await anki.getEaseFactors(cards: [1])
            XCTFail()
        } catch {}
    }

    // MARK: - Card Actions

    func testGetEaseFactors() async throws {
        let request = """
            {
                "action": "getEaseFactors",
                "version": 6,
                "params": {
                    "cards": [1483959291685, 1483959293217]
                }
            }
            """
        let response = """
            {
                "result": [4100, 3900],
                "error": null
            }
            """
        networkClient.response = response
        let easeFactors = try await anki.getEaseFactors(cards: [1483959291685, 1483959293217])
        XCTAssertEqual(easeFactors, [4100, 3900])
        try networkClient.checkRequest(request)
    }

    func testSetEaseFactors() async throws {
        let request = """
            {
                "action": "setEaseFactors",
                "version": 6,
                "params": {
                    "cards": [1483959291685, 1483959293217],
                    "easeFactors": [4100, 3900]
                }
            }
            """
        let response = """
            {
                "result": [true, true],
                "error": null
            }
            """
        networkClient.response = response
        let success = try await anki.setEaseFactors(cards: [1483959291685, 1483959293217], easeFactors: [4100, 3900])
        XCTAssertEqual([true, true], success)
        try networkClient.checkRequest(request)
    }
}
