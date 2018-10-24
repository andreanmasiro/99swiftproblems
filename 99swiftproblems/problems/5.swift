extension List {
  public func forEachReversed(_ fn: (T) -> Void) {
    nextItem?.forEachReversed(fn)
    fn(value)
  }

  public func append(_ list: List<T>) {
    if let nextItem = nextItem {
      nextItem.append(list)
    } else {
      nextItem = list
    }
  }

  public func reversed() -> List<T> {
    var head: List<T>?
    var tail: List<T>?

    forEachReversed { v in
      if let currentTail = tail {
        let next = List<T>(value: v)
        currentTail.nextItem = next
        tail = next
      } else {
        head = List(value: v)
        tail = head
      }
    }

    return head!
  }
}

public class E5: Exercise {
  public func run() {
    exercise(5, "reverse") {
      let listToReverse = List(1, 1, 2, 3, 5, 8)
      return listToReverse.reversed()
    }
  }
}

