extension List {
  public func duplicate() -> List {
    let head = copy()
    head.nextItem = head.copy()
    head.nextItem?.nextItem = head.nextItem?.nextItem?.duplicate()
    return head
  }
}

public class E14: Exercise {
  public func run() {
    exercise(14, "duplicate") {
      let list = List("a", "b", "c", "c", "d")
      return list.duplicate()
    }
  }
}

