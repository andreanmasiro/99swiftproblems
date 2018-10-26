extension List where T: Equatable {
  public func pack() -> List<List<T>> {
    var lists = [List<T>]()
    var current = Optional.some(self)
    while current != nil {
      var packValues = [T]()
      repeat {
        packValues.append(current!.value)
        current = current?.nextItem
      } while current?.value == packValues[0]
      
      List(packValues).map { lists.append($0) }
      packValues = []
    }
    let x = List<List<T>>(lists)
    return x!
  }
}

public class E9: Exercise {
  public func run() {
    exercise(9, "pack") {
      let packedList = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
      return packedList.pack()
    }
  }
}
