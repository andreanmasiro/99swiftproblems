extension List {
    public var pennultimate: T? {
        guard let nextItem = nextItem else {
            return nil
        }

        return nextItem.nextItem == nil ? value : nextItem.pennultimate
    }
}

public class E2: Exercise {
    public func run() {
        exercise(2, "penultimate") {
            return """
            \(List(1, 1, 2, 3, 5, 8).pennultimate)
            \(List(1, 2).pennultimate)
            \(List(1).pennultimate)
            """
        }
    }
}
