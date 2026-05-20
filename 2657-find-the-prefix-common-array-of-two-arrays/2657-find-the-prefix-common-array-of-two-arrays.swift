class Solution {
    /**
     Problem Summary:
     Given two integer arrays `A` and `B`, return an array where each index `i`
     contains the number of values that appear in both prefixes:
     `A[0...i]` and `B[0...i]`.

     Strategy:
     Track how many times each value has appeared across both prefixes.
     When a value reaches a frequency of `2`, it means it has appeared in both
     arrays' prefixes, so we increase the common count.

     Time Complexity:
     O(n), because each index is processed once.

     Space Complexity:
     O(n), for the frequency array and result array.
     */
    func findThePrefixCommonArray(_ firstArray: [Int], _ secondArray: [Int]) -> [Int] {
        let arrayLength = firstArray.count

        var valueFrequency = Array(repeating: 0, count: arrayLength + 1)
        var prefixCommonCounts = Array(repeating: 0, count: arrayLength)

        var commonCount = 0

        for index in 0..<arrayLength {
            let firstValue = firstArray[index]
            let secondValue = secondArray[index]

            // Add the current value from the first prefix.
            valueFrequency[firstValue] += 1

            // Once frequency becomes 2, this value has appeared in both prefixes.
            if valueFrequency[firstValue] == 2 {
                commonCount += 1
            }

            // Add the current value from the second prefix.
            valueFrequency[secondValue] += 1

            // Once frequency becomes 2, this value has appeared in both prefixes.
            if valueFrequency[secondValue] == 2 {
                commonCount += 1
            }

            prefixCommonCounts[index] = commonCount
        }

        return prefixCommonCounts
    }
}