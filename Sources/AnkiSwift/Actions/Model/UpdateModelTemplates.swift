#if os(macOS)
struct CardTemplateForUpdate: Encodable {
    let front: String
    let back: String
    
    public init(front: String, back: String) {
        self.front = front
        self.back = back
    }
    
    enum CodingKeys : String, CodingKey {
        case front = "Front"
        case back = "Back"
    }
}

struct ModelForTemplateUpdate: Encodable {
    let name: String
    let templates: [String: CardTemplateForUpdate]
}

enum UpdateModelTemplates: AnkiAction {
    static let name = "updateModelTemplates"
    static let version = 6

    struct Params: Encodable {
        let model: ModelForTemplateUpdate
    }
    
    // The result is dropped but can be added to this library if needed.
    typealias Result = IgnoredResult
}

extension Anki {
    public func updateModelTemplates(modelName: String, templates: [CardTemplate]) async throws {
        var updateTemplates = [String: CardTemplateForUpdate]()
        for template in templates {
            updateTemplates[template.name] = CardTemplateForUpdate(front: template.front, back: template.back)
        }
        _ = try await perform(UpdateModelTemplates.self, params: .init(model: ModelForTemplateUpdate(name: modelName, templates: updateTemplates)))
    }
}
#endif
