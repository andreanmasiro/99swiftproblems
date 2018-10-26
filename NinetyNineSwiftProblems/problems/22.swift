extension List where T == Int {
  public class func range(_ from: Int, _ to: Int) -> List<T> {
    precondition(from <= to)
    
    if from == to {
      return List<T>(value: from)
    }
    
    return List<T>(value: from, nextItem: List.range(from + 1, to))
  }
}

public class E22: Exercise {
  public func run() {
    exercise(22, "range factory") {
      let list = List<Int>.range(4, 9)
      return list
    }
  }
}

