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

    func testSetSpecificValueOfCard() async throws {
        let request = """
            {
                "action": "setSpecificValueOfCard",
                "version": 6,
                "params": {
                    "card": 1483959291685,
                    "keys": ["flags", "odue"],
                    "newValues": ["1", "-100"],
                    "warning_check": false
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
        let success = try await anki.setSpecificValueOfCard(card: 1483959291685, values: [.flags(1), .odue(-100)])
        XCTAssertEqual([true, true], success)
        try networkClient.checkRequest(request)
    }

    func testSuspend() async throws {
        let request = """
            {
                "action": "suspend",
                "version": 6,
                "params": {
                    "cards": [1483959291685, 1483959293217]
                }
            }
            """
        let response = """
            {
                "result": true,
                "error": null
            }
            """
        networkClient.response = response
        let success = try await anki.suspend(cards: [1483959291685, 1483959293217])
        XCTAssertEqual(true, success)
        try networkClient.checkRequest(request)
    }

    func testUnsuspend() async throws {
        let request = """
            {
                "action": "unsuspend",
                "version": 6,
                "params": {
                    "cards": [1483959291685, 1483959293217]
                }
            }
            """
        let response = """
            {
                "result": true,
                "error": null
            }
            """
        networkClient.response = response
        let success = try await anki.unsuspend(cards: [1483959291685, 1483959293217])
        XCTAssertEqual(true, success)
        try networkClient.checkRequest(request)
    }

    func testSuspended() async throws {
        let request = """
            {
                "action": "suspended",
                "version": 6,
                "params": {
                    "card": 1483959293217
                }
            }
            """
        let response = """
            {
                "result": true,
                "error": null
            }
            """
        networkClient.response = response
        let success = try await anki.suspended(card: 1483959293217)
        XCTAssertEqual(true, success)
        try networkClient.checkRequest(request)
    }

    func testAreSuspended() async throws {
        let request = """
            {
                "action": "areSuspended",
                "version": 6,
                "params": {
                    "cards": [1483959291685, 1483959293217, 1234567891234]
                }
            }
            """
        let response = """
            {
                "result": [false, true, null],
                "error": null
            }
            """
        networkClient.response = response
        let success = try await anki.areSuspended(cards: [1483959291685, 1483959293217, 1234567891234])
        XCTAssertEqual([false, true, nil], success)
        try networkClient.checkRequest(request)
    }
}
