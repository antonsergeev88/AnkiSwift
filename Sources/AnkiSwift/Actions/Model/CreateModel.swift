#if os(macOS)
public struct CardTemplate: Encodable {
    let name: String
    let front: String
    let back: String
    
    public init(name: String, front: String, back: String) {
        self.name = name
        self.front = front
        self.back = back
    }
    
    enum CodingKeys : String, CodingKey {
        case name = "Name"
        case front = "Front"
        case back = "Back"
    }
}

enum CreateModel: AnkiAction {
    static let name = "createModel"
    static let version = 6

    struct Params: Encodable {
        let modelName: String
        let inOrderFields: [String]
        let css: String?
        let isCloze: Bool
        let cardTemplates: [CardTemplate]
    }
    
    // The result is dropped but can be added to this library if needed.
    typealias Result = IgnoredResult
}

extension Anki {
    public func createModel(modelName: String, inOrderFields: [String], css: String?, isCloze: Bool, cardTemplates: [CardTemplate]) async throws {
        _ = try await perform(CreateModel.self, params: .init(modelName: modelName, inOrderFields: inOrderFields, css: css, isCloze: isCloze, cardTemplates: cardTemplates))
    }
}
#endif
