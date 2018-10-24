public func zip<T, U>(_ list1: List<T>, _ list2: List<U>) -> List<(T, U)> {
  let zhead = List<(T, U)>(value: (list1.value, list2.value))
  var ztail = zhead
  var (l1next, l2next) = (list1.nextItem, list2.nextItem)

  while let next1 = l1next, let next2 = l2next {
    let next = List<(T, U)>(value: (next1.value, next2.value))

    defer {
      ztail = next
      l1next = next1.nextItem
      l2next = next2.nextItem
    }

    ztail.nextItem = next
  }

  return zhead
}

extension List where T: Equatable {
  public func isPalindrome() -> Bool {
    guard nextItem != nil else { return false }

    var head = Optional.some(zip(self, reversed()))

    while let h = head {
      guard h.value.0 == h.value.1 else { return false }
      head = h.nextItem
    }

    return true
  }
}

public class E6: Exercise {
  public func run() {
    exercise(6, "isPalindrome") {
      return List(2, 1, 2, 2, 1, 2).isPalindrome()
    }
  }
}
