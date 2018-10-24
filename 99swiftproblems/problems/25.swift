extension List {
  func randomPermute() -> List {
    return randomSelect(length)
  }
}

public class E25: Exercise {
  public func run() {
    exercise(25, "randomPermute") {
      return List("a", "b", "c", "d", "e", "f").randomPermute()
    }
  }
}

