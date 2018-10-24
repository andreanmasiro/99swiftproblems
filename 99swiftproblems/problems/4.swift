extension List {
  public var length: Int {
    return 1 + (nextItem?.length ?? 0)
  }
}

public class E4: Exercise {
  public func run() {
    exercise(4, "length") {
      return List(1, 1, 2, 3, 5, 8).length
    }
  }
}
