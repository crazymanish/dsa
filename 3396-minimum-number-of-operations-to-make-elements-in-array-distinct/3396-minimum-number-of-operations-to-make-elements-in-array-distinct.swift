class Solution {
    func minimumOperations(_ numbers: [Int]) -> Int {
        let arrayLength = numbers.count // Store the number of elements for clarity
        var uniqueNumbers = Set<Int>() // Use a Set to efficiently track unique numbers

        // Iterate through the array in reverse order (from the last element to the first)
        for currentIndex in (0..<arrayLength).reversed() {
            let currentNumber = numbers[currentIndex] // Get the current number

            // If we've already encountered this number, we need to remove elements up to this point
            if uniqueNumbers.contains(currentNumber) {
                // Calculate the number of operations needed to remove elements up to currentIndex
                // Each operation removes 3 elements, so we divide and round up to the nearest integer
                let elementsToRemove = currentIndex + 1 // Number of elements to remove
                let operationsNeeded = Int(ceil(Double(elementsToRemove) / 3.0)) // Calculate operations (using ceil to round up)
                return operationsNeeded // Return the result
            } else {
                // Otherwise, add the number to the set of unique numbers
                uniqueNumbers.insert(currentNumber)
            }
        }

        // If the loop completes without finding duplicates, no operations are needed
        return 0
    }
}