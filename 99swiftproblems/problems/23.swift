extension List {
    public func randomSelect(_ amount: Int) -> List {
        precondition(amount > 0)
        var remainderIndices = [Int]()
        var options = [Int](0..<length)
        for _ in 0..<amount {
            remainderIndices.append(options.remove(at: Int.random(in: 0..<options.count)))
        }

        let head = List<T>(value: self[remainderIndices.removeLast()]!)
        var tail = Optional.some(head)
        while let index = remainderIndices.popLast() {
            let next = List<T>(value: self[index]!)
            tail?.nextItem = next
            tail = next
        }

        return head

        //        func randomAdvances(_ amount: Int, options: [Int]) -> [Int] {
        //            var remainderIndices = [Int]()
        //            var options = options
        //            for _ in 0..<amount {
        //                remainderIndices.append(options.remove(at: Int.random(in: 0..<options.count)))
        //            }
        //            remainderIndices.sort()
        //
        //            for i in 1...amount {
        //                let currentValue = remainderIndices[remainderIndices.count - i]
        //                let prevIndex = remainderIndices.count - i - 1
        //                let prevValue = prevIndex >= 0 ? remainderIndices[prevIndex] : 0
        //                remainderIndices[remainderIndices.count - i] = currentValue - prevValue
        //            }
        //
        //            remainderIndices.reverse()
        //
        //            return remainderIndices
        //        }
        //
        //        var remainderAdvances = randomAdvances(amount, options: [Int](0..<length))
        //        var head: List<T>?
        //        var tail: List<T>?
        //        var currentIterable = self
        //        while let advCount = remainderAdvances.popLast(), let advanced = currentIterable.advanced(by: advCount) {
        //            currentIterable = advanced
        //            if head != nil {
        //                tail?.nextItem = List(value: advanced.value)
        //                tail = tail?.nextItem
        //            } else {
        //                head = List(value: advanced.value, nextItem: tail)
        //                tail = head
        //            }
        //        }
        //
        //        return head!
    }
}

public class E23: Exercise {
    public func run() {
        exercise(23, "randomSelect") {
            let list = List("a", "b", "c", "d", "e", "f", "g", "h")
            return list.randomSelect(7)
        }
    }
}

