#if os(macOS)
struct ModelForStylingUpdate: Encodable {
    let name: String
    let css: String
}

enum UpdateModelStyling: AnkiAction {
    static let name = "updateModelStyling"
    static let version = 6

    struct Params: Encodable {
        let model: ModelForStylingUpdate
    }
    
    // The result is dropped but can be added to this library if needed.
    typealias Result = IgnoredResult
}

extension Anki {
    public func updateModelStyling(modelName: String, css: String) async throws {
        _ = try await perform(UpdateModelStyling.self, params: .init(model: ModelForStylingUpdate(name: modelName, css: css)))
    }
}
#endif
