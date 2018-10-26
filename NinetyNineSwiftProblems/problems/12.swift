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
  
  public func decode() -> List<String> {
    let (head, tail) = disjointed()
    tail.nextItem = nextItem?.decode()
    return head
  }
}


public class E12: Exercise {
  public func run() {
    exercise(12, "decode") {
      let list = List((4, "a"), (1, "b"), (2, "c"), (2, "a"), (1, "d"), (4, "e"))
      return list.decode()
    }
  }
}

