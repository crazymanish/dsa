class Solution {
    func countPairs(_ numbers: [Int], _ k: Int) -> Int {
        let arrayLength = numbers.count // Store the length of the input array for efficiency
        var validPairCount = 0 // Initialize the count of valid pairs

        // Iterate through all possible pairs of indices (i, j) where i < j
        for firstIndex in 0..<arrayLength {
            for secondIndex in (firstIndex + 1)..<arrayLength {
                // Check if the numbers at the current indices are equal and their product is divisible by k
                if numbers[firstIndex] == numbers[secondIndex] && (firstIndex * secondIndex) % k == 0 {
                    validPairCount += 1 // Increment the count if the conditions are met
                }
            }
        }

        return validPairCount // Return the total count of valid pairs
    }
}