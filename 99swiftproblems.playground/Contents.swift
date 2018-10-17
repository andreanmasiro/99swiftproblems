func exercise(_ no: Int, _ description: String? = nil, closure: () -> Void) {
    print("----- Exercise Nº\(no) -----")
    if let description = description {
        print("\(description):")
    }
    closure()
    print()
}

class List<T> {
    var value: T
    var nextItem: List<T>?

    convenience init(_ values: T...) {
        self.init(Array(values))!
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
    print(List(1, 1, 2, 3, 5, 8).last)
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
    print(List(1, 1, 2, 3, 5, 8).pennultimate)
    print(List(1, 2).pennultimate)
    print(List(1).pennultimate)
}

extension List {
    subscript(index: Int) -> T? {
        return index == 0 ? value : nextItem?[index - 1]
    }
}

exercise(3, "subscript") {
    let list = List(1, 1, 2, 3, 5, 8)
    print(list[2])
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
    print(List(1, 1, 2, 3, 5, 8).length)
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
    print(listToReverse)
    print(List(1, 1, 2, 3, 5, 8).reversed())
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
    print(List(2, 1, 2, 3, 2, 1, 2).isPalindrome())
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
    print(List<Any>(List<Any>(1,
                              1),
                    2,
                    List<Any>(3,
                              List<Any>(5,
                                        8,
                                        List<Any>(13,
                                                  List<Any>(21,
                                                            34)))))
        .flatten())

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
    print(compressedList)
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
    print(packedList.pack())
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
    print(list.encode())
}

extension List where T: Equatable {
    func encodeModified() -> List<Any> {
        let encoded = self.encoded()
    }
}

exercise(11, "encodeModified") {
    let list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
    list.encodeModified()
}
