import Collections

class NumberContainers {
    // Dictionary to store the number at each index.
    var numberAtIndex = [Int: Int]()

    // Dictionary to store a min-heap of indices for each number.
    var indicesForNumber = [Int: Heap<Int>]()

    func change(_ index: Int, _ number: Int) {
        // Update the number at the given index.
        numberAtIndex[index] = number

        // Add the index to the min-heap for the given number.
        indicesForNumber[number, default: []].insert(index)
    }

    func find(_ number: Int) -> Int {
        // While the smallest index for the number points to a different number, remove it.
        while let index = indicesForNumber[number]?.min, numberAtIndex[index] != number {
            indicesForNumber[number]?.popMin()
        }

        // Return the smallest valid index for the number, or -1 if none exists.
        return indicesForNumber[number]?.min ?? -1
    }
}

/**
 * Your NumberContainers object will be instantiated and called as such:
 * let obj = NumberContainers()
 * obj.change(index, number)
 * let ret_2: Int = obj.find(number)
 */