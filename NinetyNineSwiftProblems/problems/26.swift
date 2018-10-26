extension Array {
  public func combinations(_ group: Int) -> [[Element]] {
    if group >= count { return [self] }
    
    guard group > 1 else {
      return map { [$0] }
    }
    
    let result = Array(self[1...]).combinations(group - 1).map { a in
      [self[0]] + a
    }
    
    return result + Array(self[1...]).combinations(group)
  }
}

extension List {
  public func mapNodes<U>(_ fn: (List<T>) -> U) -> List<U> {
    return List<U>(value: fn(self), nextItem: nextItem?.mapNodes(fn))
  }
  
  public func combinations(_ group: Int) -> List<List<T>> {
    precondition(group > 0)
    let lists = Array(list: self).combinations(group).compactMap { array in
      return List<T>(values: array)
    }
    
    return List<List<T>>(values: lists)!
  }
}

public class E26: Exercise {
  public func run() {
    exercise(26, "combinations") {
      return List("1", "2", "3", "4").combinations(2)
    }
  }
}

