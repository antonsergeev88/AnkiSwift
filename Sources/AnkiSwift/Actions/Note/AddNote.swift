#if os(macOS)
struct Note: Encodable {
    let deckName: String
    let modelName: String
    let fields: [String: String]
    let options: AddNoteOptions
    let tags: [String]
}

struct AddNoteOptions: Encodable {
    let allowDuplicate: Bool
    let duplicateScope: String
    let duplicateScopeOptions: AddNoteDuplicateScopeOptions
}

struct AddNoteDuplicateScopeOptions: Encodable {
    let deckName: String?
    let checkChildren: Bool
    let checkAllModels: Bool
}

enum AddNote: AnkiAction {
    static let name = "addNote"
    static let version = 6

    struct Params: Encodable {
        let note: Note
    }

    typealias Result = NoteID
}

extension Anki {
    public func addNote(deck: String, model: String, fields: [String: String], allowDuplicate: Bool, duplicateScope: String = "", duplicateScopeDeckName: String? = nil, duplicateScopeCheckChildren: Bool = false, duplicateScopeCheckAllModels: Bool = false, tags: [String]) async throws -> NoteID {
        return try await perform(AddNote.self, params: .init(note: Note(deckName: deck, modelName: model, fields: fields, options: .init(allowDuplicate: allowDuplicate, duplicateScope: duplicateScope, duplicateScopeOptions: .init(deckName: duplicateScopeDeckName, checkChildren: duplicateScopeCheckChildren, checkAllModels: duplicateScopeCheckAllModels)), tags: tags)))
    }
}
#endif
