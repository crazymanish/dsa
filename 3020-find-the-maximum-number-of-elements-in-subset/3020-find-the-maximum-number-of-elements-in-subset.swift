class Solution {
    /*
     Problem Summary:
     Find the maximum length of a valid sequence where each next value is the square
     of the previous value, and the sequence is symmetric around a center value.

     Strategy:
     - Count the frequency of each number.
     - Try each number as a possible starting value.
     - A number can be placed on both sides only if it appears at least twice.
     - The next squared value must exist to become the next center candidate.
     - Handle 1 separately because 1 * 1 = 1.

     Time Complexity: O(n * log log maxValue) in practice
     Space Complexity: O(k)
     */
    func maximumLength(_ nums: [Int]) -> Int {
        var frequencyByNumber = [Int: Int]()

        // Count occurrences of every number.
        for number in nums {
            frequencyByNumber[number, default: 0] += 1
        }

        var maximumLength = 1

        // Special case for 1:
        // Since 1 squared is still 1, we can only use an odd number of 1s.
        if let onesCount = frequencyByNumber[1] {
            let validOnesLength = onesCount.isMultiple(of: 2) ? onesCount - 1 : onesCount
            maximumLength = max(maximumLength, validOnesLength)
        }

        for startNumber in frequencyByNumber.keys where startNumber > 1 {
            var currentNumber = startNumber
            var currentLength = 1

            // We can expand only when:
            // 1. currentNumber has a pair for both sides
            // 2. currentNumber squared exists as the next center candidate
            while let currentCount = frequencyByNumber[currentNumber],
                  currentCount >= 2,
                  frequencyByNumber[currentNumber * currentNumber] != nil {

                currentLength += 2
                currentNumber *= currentNumber
            }

            maximumLength = max(maximumLength, currentLength)
        }

        return maximumLength
    }
}