extension Sequence {

  /// Returns the elements of `self` sorted by their respective values at `p`.
  public func sorted<T: Comparable>(by p: KeyPath<Element, T>) -> [Element] {
    self.sorted(by: { (a, b) in a[keyPath: p] < b[keyPath: p] })
  }

  /// Returns the least element in `self` according to `areInIncreasingOrder`, or `nil` if `self`
  /// contains no such element.
  public func least(by areInIncreasingOrder: (Element, Element) -> Bool) -> Element? {
    var it = makeIterator()
    var leaves: [Element] = []
    var hasLeast = false

    while let x = it.next() {
      if hasLeast {
        if areInIncreasingOrder(leaves[0], x) {
          continue
        } else if !areInIncreasingOrder(x, leaves[0]) {
          leaves.append(x)
          hasLeast = false
          continue
        }
      }

      if leaves.allSatisfy({ (y) in areInIncreasingOrder(x, y) }) {
        leaves = [x]
        hasLeast = true
      }
    }

    return hasLeast ? leaves[0] : nil
  }

  /// Returns the descriptions of all elements, joined by the given `separator`.
  public func descriptions(joinedBy separator: String = ", ") -> String {
    var result = ""
    var first = true
    for x in self {
      if first { first = false } else { result.append(separator) }
      result.append(String(describing: x))
    }
    return result
  }

}
