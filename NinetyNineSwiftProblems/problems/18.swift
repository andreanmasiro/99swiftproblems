extension List {
  public func slice(_ from: Int, _ to: Int) -> List {
    guard from < to else { fatalError("to(\(to)) must be greater than from(\(from))") }
    guard let head = advanced(by: from)?.copy() else { fatalError("index out of bounds") }
    
    head.advanced(by: to - from - 1)?.nextItem = nil
    
    return head
  }
}

public class E18: Exercise {
  public func run() {
    exercise(18, "slice") {
      let list = List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k")
      return list.slice(3, 7)
    }
  }
}

