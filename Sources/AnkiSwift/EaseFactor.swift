public struct EaseFactor: RawRepresentable, ExpressibleByIntegerLiteral, Equatable, Codable {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public init(integerLiteral value: IntegerLiteralType) {
        self.init(rawValue: value)
    }
}
