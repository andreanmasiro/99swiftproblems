extension List {
    public func duplicate(times: Int) -> List {
        if times == 0 {
            return self
        } else {
            let head = copy()
            head.nextItem = head.copy()
            head.nextItem?.nextItem = head.nextItem?.nextItem?.duplicate(times: times - 1)
            return head
        }
    }
}

public class E15: Exercise {
    public func run() {
        exercise(15, "duplicateTimes") {
            let list = List("a", "b", "c", "c", "d")
            return list.duplicate(times: 3)
        }
    }
}

