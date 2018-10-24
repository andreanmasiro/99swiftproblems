extension Array where Element: Equatable {
  func group3() -> [[[Element]]] {
    var result = [[[Element]]]()
    let groups2 = combinations(2)
    for g2 in groups2 {
      let g3Remainders = filter { !g2.contains($0) }
      let groups3 = g3Remainders.combinations(3)
      for g3 in groups3 {
        let g4Remainders = g3Remainders.filter { !g3.contains($0) }
        let groups4 = g4Remainders.combinations(4)
        for g4 in groups4 {
          result.append([g2, g3, g4])
        }
      }
    }
    return result
  }
}

extension List where T: Equatable {
  func group3() -> List<List<List<T>>> {
    let array = Array(list: self)
    let x = array.group3().compactMap {
      List<List<T>>(values: $0.compactMap(List<T>.init(values:)))
    }

    return List<List<List<T>>>(values: x)!
  }
}

class E27: Exercise {
  func run() {
    exercise(27) {
      let list = List("Aldo", "Beat", "Carla", "David", "Evi", "Flip", "Gary", "Hugo", "Ida")
      return list.group3().slice(0, 10)
    }
  }
}
