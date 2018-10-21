extension List {
    public func append(_ list: List<T>) {
        if let nextItem = nextItem {
            nextItem.append(list)
        } else {
            nextItem = list
        }
    }

    public func reversed() -> List<T> {
        var reversed = self
        if let nextItem = nextItem {
            self.nextItem = nil
            reversed = nextItem.reversed()
            reversed.append(self)
        }
        return reversed
    }

    public func reverse() {
        guard nextItem != nil else { return }

        var values = Array(list: self)

        var current = Optional.some(self)
        while current != nil,
            let value = values.popLast() {
                current?.value = value
                current = current?.nextItem
        }
    }
}

public class E5: Exercise {
    public func run() {
        exercise(5, "reverse") {
            let listToReverse = List(1, 1, 2, 3, 5, 8)
            listToReverse.reverse()
            return """
            \(listToReverse)
            \(List(1, 1, 2, 3, 5, 8).reversed())
            """
        }
    }
}

