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
            _ = try await anki.forgetCards(cards: [1])
        } catch {
            XCTFail()
        }
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

    func testFindCards() async throws {
        let request = """
            {
                "action": "findCards",
                "version": 6,
                "params": {
                    "query": "deck:current"
                }
            }
            """
        let response = """
            {
                "result": [1494723142483, 1494703460437, 1494703479525],
                "error": null
            }
            """
        networkClient.response = response
        let cards = try await anki.findCards(query: "deck:current")
        XCTAssertEqual([1494723142483, 1494703460437, 1494703479525], cards)
        try networkClient.checkRequest(request)
    }

    func testCardsToNotes() async throws {
        let request = """
            {
                "action": "cardsToNotes",
                "version": 6,
                "params": {
                    "cards": [1502098034045, 1502098034048, 1502298033753]
                }
            }
            """
        let response = """
            {
                "result": [1502098029797, 1502298025183],
                "error": null
            }
            """
        networkClient.response = response
        let notes = try await anki.cardsToNotes(cards: [1502098034045, 1502098034048, 1502298033753])
        XCTAssertEqual([1502098029797, 1502298025183], notes)
        try networkClient.checkRequest(request)
    }

    func testCardsModTime() async throws {
        let request = """
            {
                "action": "cardsModTime",
                "version": 6,
                "params": {
                    "cards": [1498938915662, 1502098034048]
                }
            }
            """
        let response = """
            {
                "result": [
                    {
                        "cardId": 1498938915662,
                        "mod": 1629454092
                    }
                ],
                "error": null
            }
            """
        networkClient.response = response
        let result = try await anki.cardsModTime(cards: [1498938915662, 1502098034048])
        XCTAssertEqual([1498938915662], result.map(\.cardId))
        XCTAssertEqual([1629454092], result.map(\.mod))
        try networkClient.checkRequest(request)
    }

    func testCardsInfo() async throws {
        let request = """
            {
                "action": "cardsInfo",
                "version": 6,
                "params": {
                    "cards": [1498938915662, 1502098034048]
                }
            }
            """
        let response = """
            {
                "result": [
                    {
                        "answer": "back content",
                        "question": "front content",
                        "deckName": "Default",
                        "modelName": "Basic",
                        "fieldOrder": 1,
                        "fields": {
                            "Front": {"value": "front content", "order": 0},
                            "Back": {"value": "back content", "order": 1}
                        },
                        "css":"p {font-family:Arial;}",
                        "cardId": 1498938915662,
                        "interval": 16,
                        "factor": 0,
                        "note":1502298033753,
                        "ord": 1,
                        "type": 0,
                        "queue": 0,
                        "due": 1,
                        "reps": 1,
                        "lapses": 0,
                        "left": 6,
                        "mod": 1629454092
                    }
                ],
                "error": null
            }
            """
        networkClient.response = response
        let result = try await anki.cardsInfo(cards: [1498938915662, 1502098034048])
        XCTAssertEqual("back content", result.first?.answer)
        XCTAssertEqual(1629454092, result.first?.mod)
        try networkClient.checkRequest(request)
    }

    func testForgetCards() async throws {
        let request = """
            {
                "action": "forgetCards",
                "version": 6,
                "params": {
                    "cards": [1498938915662, 1502098034048]
                }
            }
            """
        let response = """
            {
                "result": null,
                "error": null
            }
            """
        networkClient.response = response
        _ = try await anki.forgetCards(cards: [1498938915662, 1502098034048])
        try networkClient.checkRequest(request)
    }

    func testRelearnCards() async throws {
        let request = """
            {
                "action": "relearnCards",
                "version": 6,
                "params": {
                    "cards": [1498938915662, 1502098034048]
                }
            }
            """
        let response = """
            {
                "result": null,
                "error": null
            }
            """
        networkClient.response = response
        _ = try await anki.relearnCards(cards: [1498938915662, 1502098034048])
        try networkClient.checkRequest(request)
    }

    // MARK: - Deck Actions

    func testDeckNames() async throws {
        let request = """
            {
                "action": "deckNames",
                "version": 6,
                "params": {}
            }
            """
        let response = """
            {
                "result": ["Default"],
                "error": null
            }
            """
        networkClient.response = response
        let deckNames = try await anki.deckNames()
        XCTAssertEqual(["Default"], deckNames)
        try networkClient.checkRequest(request)
    }

    func testDeckNamesAndIds() async throws {
        let request = """
            {
                "action": "deckNamesAndIds",
                "version": 6,
                "params": {}
            }
            """
        let response = """
            {
                "result": {"Default": 1},
                "error": null
            }
            """
        networkClient.response = response
        let deckNamesAndIds = try await anki.deckNamesAndIds()
        XCTAssertEqual(["Default": 1], deckNamesAndIds)
        try networkClient.checkRequest(request)
    }

    func testGetDecks() async throws {
        let request = """
            {
                "action": "getDecks",
                "version": 6,
                "params": {
                    "cards": [1502298036657, 1502298033753, 1502032366472]
                }
            }
            """
        let response = """
            {
                "result": {
                    "Default": [1502032366472],
                    "Japanese::JLPT N3": [1502298036657, 1502298033753]
                },
                "error": null
            }
            """
        networkClient.response = response
        let decks = try await anki.getDecks(cards: [1502298036657, 1502298033753, 1502032366472])
        XCTAssertEqual([1502032366472], decks["Default"])
        XCTAssertEqual([1502298036657, 1502298033753], decks["Japanese::JLPT N3"])
        try networkClient.checkRequest(request)
    }

    func testCreateDeck() async throws {
        let request = """
            {
                "action": "createDeck",
                "version": 6,
                "params": {
                    "deck": "Japanese::Tokyo"
                }
            }
            """
        let response = """
            {
                "result": 1519323742721,
                "error": null
            }
            """
        networkClient.response = response
        let deckId = try await anki.createDeck(deck: "Japanese::Tokyo")
        XCTAssertEqual(1519323742721, deckId)
        try networkClient.checkRequest(request)
    }

    func testChangeDeck() async throws {
        let request = """
            {
                "action": "changeDeck",
                "version": 6,
                "params": {
                    "cards": [1502098034045, 1502098034048, 1502298033753],
                    "deck": "Japanese::JLPT N3"
                }
            }
            """
        let response = """
            {
                "result": null,
                "error": null
            }
            """
        networkClient.response = response
        _ = try await anki.changeDeck(cards: [1502098034045, 1502098034048, 1502298033753], deck: "Japanese::JLPT N3")
        try networkClient.checkRequest(request)
    }

    func testDeleteDecks() async throws {
        let request = """
            {
                "action": "deleteDecks",
                "version": 6,
                "params": {
                    "decks": ["Japanese::JLPT N5", "Easy Spanish"],
                    "cardsToo": true
                }
            }
            """
        let response = """
            {
                "result": null,
                "error": null
            }
            """
        networkClient.response = response
        _ = try await anki.deleteDecks(decks: ["Japanese::JLPT N5", "Easy Spanish"])
        try networkClient.checkRequest(request)
    }
}
