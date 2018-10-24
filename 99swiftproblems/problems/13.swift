extension List where T: Equatable {
  public func encodeDirect() -> List<(Int, T)> {
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

public class E13: Exercise {
  public func run() {
    exercise(13, "encodeDirect") {
      let list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
      return list.encodeDirect()
    }
  }
}

