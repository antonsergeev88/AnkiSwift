protocol AnkiAction {
    static var name: String { get }
    static var version: Int { get }
    associatedtype Params: Encodable
    associatedtype Result: Decodable
}
