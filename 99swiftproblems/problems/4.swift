extension List {
    public var length: Int {
        guard let nextItem = nextItem else {
            return 1
        }

        return nextItem.length + 1
    }
}

public class E4: Exercise {
    public func run() {
        exercise(4, "length") {
            return List(1, 1, 2, 3, 5, 8).length
        }
    }
}
