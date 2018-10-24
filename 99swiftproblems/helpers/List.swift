public class List<T> {
  public var value: T
  public var nextItem: List<T>?
  
  public convenience init(_ values: T...) {
    self.init(Array(values))!
  }
  
  public init(value: T, nextItem: List<T>? = nil) {
    self.value = value
    self.nextItem = nextItem
  }
  
  public init?(_ values: [T]) {
    guard let first = values.first else {
      return nil
    }
    value = first
    nextItem = List(Array(values.suffix(from: 1)))
  }
  
  public init?(values: [T]) {
    guard let first = values.first else {
      return nil
    }
    value = first
    nextItem = List(Array(values.suffix(from: 1)))
  }
  
  public func forEach(_ run: (T) -> Void) {
    run(value)
    nextItem?.forEach(run)
  }
  
  public func forEachNode(_ run: (List<T>) -> Void) {
    run(self)
    nextItem?.forEachNode(run)
  }
  
  public func copy() -> List<T> {
    return List<T>(value: value, nextItem: nextItem)
  }
  
  public func deepCopy() -> List<T> {
    return List<T>(value: value, nextItem: nextItem?.deepCopy())
  }
  
  public func advanced(by index: Int) -> List<T>? {
    precondition(index >= 0)
    return index == 0 ? self : nextItem?.advanced(by: index - 1)
  }
  
  public func tail() -> List<T> {
    return nextItem?.tail() ?? self
  }
  
  public func dropLast() -> List<T>? {
    if nextItem == nil {
      return nil
    }
    
    let head = deepCopy()
    var newTail = Optional.some(head)
    
    while let prev = newTail, let mid = prev.nextItem, mid.nextItem != nil {
      newTail = mid
    }
    
    newTail?.nextItem = nil
    
    return head
  }
  
  public func popLast() -> T {
    if nextItem == nil {
      return value
    }
    
    let head = self
    var newTail = Optional.some(head)
    
    while let prev = newTail, let mid = prev.nextItem, mid.nextItem != nil {
      newTail = mid
    }
    let last = newTail?.nextItem
    newTail?.nextItem = nil
    
    return last!.value
  }
}

extension List: Loggable {
  public var log: String {
    var d = "[\(getLog(value))"
    var current = nextItem
    while current != nil {
      d += " -> \(getLog(current!.value))"
      current = current!.nextItem
    }
    return d + "]"
  }
}
