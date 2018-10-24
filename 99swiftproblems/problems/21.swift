extension List {
  public func insert(at index: Int, _ value: T) {
    precondition(index >= 0)
    if index == 0 {
      nextItem = copy()
      self.value = value
      return
    }
    
    nextItem?.insert(at: index - 1, value)
  }
}

public class E21: Exercise {
  public func run() {
    exercise(21, "insertAt") {
      let list = List("a", "b", "c", "d")
      list.insert(at: 1, "new")
      return list
    }
  }
}

