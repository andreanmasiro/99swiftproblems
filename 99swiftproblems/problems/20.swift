extension List {
  public func removeAt(_ position: Int) -> (rest: List?, removed: T?) {
    if position == 0 { return (nextItem, value) }
    
    let head = self
    guard let prev = head.advanced(by: position - 1) else {
      return (head, nil)
    }
    
    let removed = prev.nextItem?.value
    prev.nextItem = prev.nextItem?.nextItem
    return (head, removed)
  }
}

public class E20: Exercise {
  public func run() {
    exercise(20, "removeAt") {
      let list = List("a", "b", "c", "d")
      let result = list.removeAt(0)
      return """
      \(result.rest)
      \(result.removed)
      """
    }
  }
}
