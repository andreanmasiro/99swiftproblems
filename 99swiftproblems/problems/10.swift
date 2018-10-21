extension List where T: Equatable {
    public func encode() -> List<(Int, T)> {
        let l = pack()
        var v = [(Int, T)]()
        var current = Optional.some(l)

        while current != nil {
            v.append((current!.value.length, current!.value.value))
            current = current?.nextItem
        }

        return List<(Int, T)>(v)!
    }
}

public class E10: Exercise {
    public func run() {
        exercise(10, "encode") {
            let list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
            return list.encode()
        }
    }
}

