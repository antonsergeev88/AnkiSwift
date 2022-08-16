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

    func testAreDue() async throws {
        let request = """
            {
                "action": "areDue",
                "version": 6,
                "params": {
                    "cards": [1483959291685, 1483959293217]
                }
            }
            """
        let response = """
            {
                "result": [false, true],
                "error": null
            }
            """
        networkClient.response = response
        let success = try await anki.areDue(cards: [1483959291685, 1483959293217])
        XCTAssertEqual([false, true], success)
        try networkClient.checkRequest(request)
    }

    func testGetIntervals() async throws {
        let request = """
            {
                "action": "getIntervals",
                "version": 6,
                "params": {
                    "cards": [1502298033753, 1502298036657]
                }
            }
            """
        let response = """
            {
                "result": [-14400, 3],
                "error": null
            }
            """
        networkClient.response = response
        let intervals = try await anki.getIntervals(cards: [1502298033753, 1502298036657])
        XCTAssertEqual([-14400, 3], intervals)
        try networkClient.checkRequest(request)
    }

    func testGetIntervalsComplete() async throws {
        let request = """
            {
                "action": "getIntervals",
                "version": 6,
                "params": {
                    "cards": [1502298033753, 1502298036657],
                    "complete": true
                }
            }
            """
        let response = """
            {
                "result": [
                    [-120, -180, -240, -300, -360, -14400],
                    [-120, -180, -240, -300, -360, -14400, 1, 3]
                ],
                "error": null
            }
            """
        networkClient.response = response
        let intervals = try await anki.getIntervalsComplete(cards: [1502298033753, 1502298036657])
        XCTAssertEqual([
            [-120, -180, -240, -300, -360, -14400],
            [-120, -180, -240, -300, -360, -14400, 1, 3],
        ], intervals)
        try networkClient.checkRequest(request)
    }
}
