extension Array {
    public func permutations() -> [[Element]] {
        if count == 1 {
            return [self]
        }

        let value = self[0]

        var perms = [[Element]]()
        let sperms = Array(self[1...]).permutations()
        for perm in sperms {
            for i in 0...(count - 1) {
                let p: [Element]
                switch i {
                case 0: p = [value] + perm
                case perm.count: p = perm + [value]
                default: p = perm[0..<i] + [value] + perm[i...]
                }
                perms.append(p)
            }
        }
        return perms
    }

    func permutations(_ group: Int) -> [[Element]] {
        let combs = combinations(group)
        return combs.flatMap { $0.permutations() }
    }
}

extension List {
    public func permutations(_ group: Int) -> List<List<T>> {
        let lists = Array(list: self)
            .permutations(group)
            .compactMap { array in
                return List<T>(values: array)
        }
        return List<List<T>>(values: lists)!
    }
}

public class E26B: Exercise {
    public func run() {
        exercise(26, "permutations") {
            return List("a", "b", "c").permutations(2)
        }
    }
}
