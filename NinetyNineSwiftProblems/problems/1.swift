extension List {
  public var last: T {
    return nextItem?.last ?? value
  }
}

class E1: Exercise {
  public func run() {
    exercise(1, "last") {
      return List(1, 1, 2, 3, 5, 8).last
    }
  }
}
