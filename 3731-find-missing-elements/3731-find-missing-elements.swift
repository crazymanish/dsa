/**
 Problem Summary:
 Find all integers missing from the continuous range between the smallest
 and largest values in the input array.

 Strategy:
 Use a fixed-size presence array to mark every value found in `nums`.
 Then scan from the smallest value to the largest value and collect values
 that were never marked.

 Time Complexity:
 O(n + range), where `range = largest - smallest + 1`

 Space Complexity:
 O(101), assuming all values are between 0 and 100.
 */
class Solution {
    func findMissingElements(_ nums: [Int]) -> [Int] {
        guard let firstNumber = nums.first else {
            return []
        }

        // The problem constraints limit values to the inclusive range 0...100.
        let maximumAllowedValue = 100
        var presenceByValue = Array(
            repeating: false,
            count: maximumAllowedValue + 1
        )

        var smallestValue = firstNumber
        var largestValue = firstNumber

        // Record each value and determine the actual range to inspect.
        for number in nums {
            smallestValue = min(smallestValue, number)
            largestValue = max(largestValue, number)
            presenceByValue[number] = true
        }

        var missingValues: [Int] = []

        // Every unmarked value within the discovered range is missing.
        for value in smallestValue...largestValue {
            if !presenceByValue[value] {
                missingValues.append(value)
            }
        }

        return missingValues
    }
}