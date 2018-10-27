extension List {
    public func flatten() -> List {
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

public class E7: Exercise {
    public func run() {
        exercise(7, "flatten") {
            let list = List<Any>(List<Any>(1,
                                           1),
                                 2,
                                 List<Any>(3,
                                           List<Any>(5,
                                                     8,
                                                     List<Any>(13,
                                                               List<Any>(21,
                                                                         34)))))
                .flatten()
            return list
        }
    }
}

