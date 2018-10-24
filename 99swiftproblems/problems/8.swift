extension List where T: Equatable {
  public func compress() {
    var current = Optional.some(self)
    while current != nil {
      var next = current?.nextItem
      while next?.value == current?.value, next != nil {
        next = next?.nextItem
      }
      current?.nextItem = next
      current = next
    }
  }
}

public class E8: Exercise {
  public func run() {
    exercise(8, "compress") {
      let compressedList = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
      compressedList.compress()
      return compressedList
    }
  }
}

