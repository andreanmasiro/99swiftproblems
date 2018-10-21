extension List where T == Int {
    public class func lotto(_ count: Int, _ maximum: Int) -> List {
        precondition(count > 0)
        var numberOptions = Array(1...maximum)
        var numbers = [Int]()
        for _ in 0..<count {
            let randomIndex = Int.random(in: 0..<numberOptions.count)
            numbers.append(numberOptions.remove(at: randomIndex))
        }
        return List<Int>(numbers)!
    }
}

public class E24: Exercise {
    public func run() {
        exercise(24, "lotto") {
            return List<Int>.lotto(6, 49)
        }
    }
}

