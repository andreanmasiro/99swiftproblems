extension List {
    public func split(atIndex index: Int) -> (left: List, right: List?) {
        let left = copy()
        guard let leftTail = left.advanced(by: index - 1) else {
            return (left, nil)
        }
        let right = leftTail.nextItem
        leftTail.nextItem = nil

        return (left, right)
    }
}

public class E17: Exercise {
    public func run() {
        exercise(17, "split") {
            let list = List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k")
            let splitted = list.split(atIndex: 3)
            return """
            \(splitted.left)
            \(splitted.right)
            """
        }
    }
}

