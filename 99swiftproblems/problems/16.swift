extension List {
    public func drop(every: Int) -> List? {
        guard every > 1 else { return nil }
        let dropped = copy()
        dropped.advanced(by: every - 2)?.nextItem = dropped.advanced(by: every - 2)?.nextItem?.nextItem?.drop(every: every)

        return dropped
    }
}

public class E16: Exercise {
    public func run() {
        exercise(16, "dropEvery") {
            let list = List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k")
            return list.drop(every: 3)
        }
    }
}

