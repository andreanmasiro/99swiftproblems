extension List where T: Equatable {
    public func encodeModified() -> List<Any> {
        let l = pack()
        var v = [Any]()
        var current = Optional.some(l)

        while current != nil, let unwrappedCurrent = current?.value {
            let length = unwrappedCurrent.length
            let value: Any = length == 1
                ? unwrappedCurrent.value
                : (unwrappedCurrent.length, unwrappedCurrent.value)
            v.append(value)
            current = current?.nextItem
        }

        return List<Any>(v)!
    }
}

public class E11: Exercise {
    public func run() {
        exercise(11, "encodeModified") {
            let list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
            return list.encodeModified()
        }
    }
}

