func exercise(_ no: Int, _ description: String? = nil, closure: () -> CustomStringConvertible?) {
    print("----- Exercise Nº\(no) -----")
    if let description = description {
        print("\(description):")
    }
    print(closure() ?? "nil")
    print()
}

class List<T> {
    var value: T
    var nextItem: List<T>?

    convenience init(_ values: T...) {
        self.init(Array(values))!
    }

    init(value: T, nextItem: List<T>? = nil) {
        self.value = value
        self.nextItem = nextItem
    }

    init?(_ values: [T]) {
        guard let first = values.first else {
            return nil
        }
        value = first
        nextItem = List(Array(values.suffix(from: 1)))
    }

    func forEach(_ run: (T) -> Void) {
        run(value)
        nextItem?.forEach(run)
    }

    func forEachNode(_ run: (List<T>) -> Void) {
        run(self)
        nextItem?.forEachNode(run)
    }

    func copy() -> List<T> {
        return List<T>(value: value, nextItem: nextItem)
    }

    func deepCopy() -> List<T> {
        return List<T>(value: value, nextItem: nextItem?.deepCopy())
    }

    func advanced(by index: Int) -> List<T>? {
        return index == 0 ? self : nextItem?.advanced(by: index - 1)
    }

    func tail() -> List<T> {
        return nextItem?.tail() ?? self
    }
}

extension Array {
    init(list: List<Element>) {
        var values = [Element]()
        var current = Optional.some(list)
        while current != nil {
            values.append(current!.value)
            current = current?.nextItem
        }

        self = values
    }
}

extension List: CustomStringConvertible {
    public var description: String {
        guard let nextItem = nextItem else {
            return "\(value) //"
        }
        return "\(value) -> \(nextItem.description)"
    }
}

extension List {
    var last: T {
        return nextItem?.last ?? value
    }
}

exercise(1, "last") {
    return List(1, 1, 2, 3, 5, 8).last
}

extension List {
    var pennultimate: T? {
        guard let nextItem = nextItem else {
            return nil
        }

        return nextItem.nextItem == nil ? value : nextItem.pennultimate
    }
}

exercise(2, "penultimate") {
    return """
    \(List(1, 1, 2, 3, 5, 8).pennultimate)
    \(List(1, 2).pennultimate)
    \(List(1).pennultimate)
    """
}

extension List {
    subscript(index: Int) -> T? {
        return index == 0 ? value : nextItem?[index - 1]
    }
}

exercise(3, "subscript") {
    let list = List(1, 1, 2, 3, 5, 8)
    return list[2]
}

extension List {
    var length: Int {
        guard let nextItem = nextItem else {
            return 1
        }

        return nextItem.length + 1
    }
}

exercise(4, "length") {
    return List(1, 1, 2, 3, 5, 8).length
}

extension List {
    func append(_ list: List<T>) {
        if let nextItem = nextItem {
            nextItem.append(list)
        } else {
            nextItem = list
        }
    }

    func reversed() -> List<T> {
        var reversed = self
        if let nextItem = nextItem {
            self.nextItem = nil
            reversed = nextItem.reversed()
            reversed.append(self)
        }
        return reversed
    }

    func reverse() {
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

exercise(5, "reverse") {
    let listToReverse = List(1, 1, 2, 3, 5, 8)
    listToReverse.reverse()
    return """
    \(listToReverse)
    \(List(1, 1, 2, 3, 5, 8).reversed())
    """
}

extension List where T:Equatable {
    func isPalindrome() -> Bool {
        guard nextItem != nil else {
            return true
        }

        var values = Array(list: self)
        for i in 0..<values.count {
            if values[i] != values[values.count - 1 - i] {
                return false
            }
        }

        return true
    }
}

exercise(6, "isPalindrome") {
    return List(2, 1, 2, 3, 2, 1, 2).isPalindrome()
}

extension List {
    func flatten() -> List {
        var head = self
        let formerNext = nextItem

        if let listValue = value as? List<T> {
            head = listValue.flatten()

            // search list tail
            var listValueTail = listValue
            while let xablau = listValueTail.nextItem {
                listValueTail = xablau
            }

            // relink list
            listValueTail.nextItem = formerNext
        }

        nextItem = nextItem?.flatten()

        return head
    }
}

exercise(7, "flatten") {
    return List<Any>(List<Any>(1,
                              1),
                    2,
                    List<Any>(3,
                              List<Any>(5,
                                        8,
                                        List<Any>(13,
                                                  List<Any>(21,
                                                            34)))))
        .flatten()

}

extension List where T: Equatable {
    func compress() {
        var current = Optional.some(self)
        while current != nil {
            var next = current?.nextItem
            while next?.value == current?.value, next != nil {
                next = next?.nextItem
            }
            current?.nextItem = next
            current = next
        }
    }
}

exercise(8, "compress") {
    let compressedList = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
    compressedList.compress()
    return compressedList
}

extension List where T: Equatable {
    func pack() -> List<List<T>> {
        var lists = [List<T>]()
        var current = Optional.some(self)
        while current != nil {
            var packValues = [T]()
            repeat {
                packValues.append(current!.value)
                current = current?.nextItem
            } while current?.value == packValues[0]

            List(packValues).map { lists.append($0) }
            packValues = []
        }
        let x = List<List<T>>(lists)
        return x!
    }
}

exercise(9, "pack") {
    let packedList = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
    return packedList.pack()
}

extension List where T: Equatable {
    func encode() -> List<(Int, T)> {
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

exercise(10, "encode") {
    let list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
    return list.encode()
}

extension List where T: Equatable {
    func encodeModified() -> List<Any> {
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

exercise(11, "encodeModified") {
    let list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
    return list.encodeModified()
}

extension List where T == (Int, String) {
    private func disjointed() -> (List<String>, List<String>) {
        let head = List<String>(value.1)
        var tail = head
        for _ in 1..<value.0 {
            let nextItem = List<String>(value.1)
            tail.nextItem = nextItem
            tail = nextItem
        }
        return (head, tail)
    }

    func decode() -> List<String> {
        let (head, tail) = disjointed()
        tail.nextItem = nextItem?.decode()
        return head
    }
}

exercise(12, "decode") {
    let list = List((4, "a"), (1, "b"), (2, "c"), (2, "a"), (1, "d"), (4, "e"))
    return list.decode()
}

extension List where T: Equatable {
    func encodeDirect() -> List<(Int, T)> {
        let head = List<(Int, T)>((1, value))
        var tail = head

        nextItem?.forEach { value in
            if value == tail.value.1 {
                tail.value.0 += 1
            } else {
                let nextItem = List<(Int, T)>((1, value))
                tail.nextItem = nextItem
                tail = nextItem
            }
        }
        return head
    }
}

exercise(13, "encodeDirect") {
    let list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
    return list.encodeDirect()
}

extension List {
    func duplicate() -> List {
        var head = copy()
        head.nextItem = head.copy()
        head.nextItem?.nextItem = head.nextItem?.nextItem?.duplicate()
        return head
    }
}

exercise(14, "duplicate") {
    let list = List("a", "b", "c", "c", "d")
    return list.duplicate()
}

extension List {
    func duplicate(times: Int) -> List {
        if times == 0 {
            return self
        } else {
            var head = copy()
            head.nextItem = head.copy()
            head.nextItem?.nextItem = head.nextItem?.nextItem?.duplicate(times: times - 1)
            return head
        }
    }
}

exercise(15, "duplicateTimes") {
    let list = List("a", "b", "c", "c", "d")
    return list.duplicate(times: 3)
}

extension List {
    func drop(every: Int) -> List? {
        guard every > 1 else { return nil }
        var dropped = copy()
        dropped.advanced(by: every - 2)?.nextItem = dropped.advanced(by: every - 2)?.nextItem?.nextItem?.drop(every: every)

        return dropped
    }
}

exercise(16, "dropEvery") {
    let list = List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k")
    return list.drop(every: 3)
}

extension List {
    func split(atIndex index: Int) -> (left: List, right: List?) {
        let left = copy()
        guard let leftTail = left.advanced(by: index - 1) else {
            return (left, nil)
        }
        let right = leftTail.nextItem
        leftTail.nextItem = nil

        return (left, right)
    }
}

exercise(17, "split") {
    let list = List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k")
    let splitted = list.split(atIndex: 3)
    return """
    \(splitted.left)
    \(splitted.right)
    """
}

extension List {
    func slice(_ from: Int, _ to: Int) -> List {
        guard from < to else { fatalError("to(\(to)) must be greater than from(\(from))") }
        guard let head = advanced(by: from)?.copy() else { fatalError("index out of bounds") }

        head.advanced(by: to - from - 1)?.nextItem = nil

        return head
    }
}

exercise(18, "slice") {
    let list = List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k")
    return list.slice(3, 7)
}

extension List {
    func rotate(_ amount: Int) -> List {
        let length = self.length
        guard amount % length != 0 else { return deepCopy() }

        let realAmount: Int
        if amount < 0 {
            let positivityCoefficient = 1 + abs(amount / length)
            realAmount = amount + Int(positivityCoefficient) * length
        } else {
            realAmount = amount % length
        }

        let head = deepCopy()
        let formerTail = head.tail()
        let newTail = head.advanced(by: realAmount - 1)!
        let newHead = newTail.nextItem

        newTail.nextItem = nil

        formerTail.nextItem = head

        return newHead!
    }
}

exercise(19, "rotate") {
    let list = List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k")
    return list.rotate(3)
}
