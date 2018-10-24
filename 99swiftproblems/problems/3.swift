extension List {
  public subscript(index: Int) -> T? {
    return index == 0 ? value : nextItem?[index - 1]
  }
}

public class E3: Exercise {
  public func run() {
    exercise(3, "subscript") {
      let list = List(1, 1, 2, 3, 5, 8)
      return list[2]
    }
  }
}
