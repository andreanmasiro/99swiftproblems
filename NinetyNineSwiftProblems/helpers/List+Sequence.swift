extension List: Sequence {
  public struct Iterator<Element>: IteratorProtocol {
    var list: List<Element>?
    
    init(_ list: List<Element>) {
      self.list = list
    }
    
    public mutating func next() -> Element? {
      defer {
        list = list?.nextItem
      }
      return list?.value
    }
  }
  
  public func makeIterator() -> Iterator<T> {
    return Iterator(self)
  }
}
