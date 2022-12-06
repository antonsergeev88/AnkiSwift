#if os(macOS)
public struct NoteID: RawRepresentable, ExpressibleByIntegerLiteral, Equatable, Codable {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public init(integerLiteral value: Int) {
        self.init(rawValue: value)
    }
}
#endif
