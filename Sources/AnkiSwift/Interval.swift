#if os(macOS)
public struct Interval: RawRepresentable, ExpressibleByIntegerLiteral, Equatable, Codable {
    public var rawValue: Int

    public var seconds: Int {
        if rawValue < 0 {
            return -rawValue
        } else {
            return rawValue * 24 * 60 * 60
        }
    }

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public init(integerLiteral value: Int) {
        self.init(rawValue: value)
    }
}
#endif
