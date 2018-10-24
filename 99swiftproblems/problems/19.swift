extension List {
  public func rotate(_ amount: Int) -> List {
    let length = self.length
    guard amount % length != 0 else { return deepCopy() }
    
    let realAmount: Int
    if amount < 0 {
      let positivityCoefficient = 1 + abs(amount / length)
      realAmount = amount + Int(positivityCoefficient) * length
    } else {
      realAmount = amount % length
    }
    
    let head = deepCopy()
    let formerTail = head.tail()
    let newTail = head.advanced(by: realAmount - 1)!
    let newHead = newTail.nextItem
    
    newTail.nextItem = nil
    
    formerTail.nextItem = head
    
    return newHead!
  }
}

public class E19: Exercise {
  public func run() {
    exercise(19, "rotate") {
      let list = List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k")
      return list.rotate(3)
    }
  }
}

