public protocol Exercise {
    func run()
}

public func exercise(_ no: Int, _ description: String? = nil, closure: () -> Loggable?) {
    print("----- Exercise Nº\(no) -----")
    if let description = description {
        print("\(description):")
    }
    print("result:", closure()?.log ?? "nil")
    print()
}

public protocol Loggable {
    var log: String { get }
}

extension Bool: Loggable {
    public var log: String { return description }
}

extension String: Loggable {
    public var log: String { return description }
}

extension Int: Loggable {
    public var log: String { return description }
}

func getLog(_ value: Any) -> String {
    if let loggable = value as? Loggable {
        return loggable.log
    }

    return String(describing: value)
}
