extension Array {
    public init(list: List<Element>) {
        var values = [Element]()
        var current = Optional.some(list)
        while current != nil {
            values.append(current!.value)
            current = current?.nextItem
        }

        self = values
    }
}
