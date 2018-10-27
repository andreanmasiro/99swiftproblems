extension List where T:Equatable {
    public func isPalindrome() -> Bool {
        guard nextItem != nil else {
            return true
        }

        var values = Array(list: self)
        for i in 0..<values.count {
            if values[i] != values[values.count - 1 - i] {
                return false
            }
        }

        return true
    }
}

public class E6: Exercise {
    public func run() {
        exercise(6, "isPalindrome") {
            return List(2, 1, 2, 3, 2, 1, 2).isPalindrome()
        }
    }
}

