class Solution {
    /**
     Problem Summary:
     Given two arrays of positive integers, return the length of the longest
     common prefix shared by any number from `arr1` and any number from `arr2`.

     Strategy:
     - Build a set containing every numeric prefix from all numbers in `arr1`.
     - For each number in `arr2`, repeatedly remove the last digit to check
       whether any prefix exists in the `arr1` prefix set.
     - Track the longest matching prefix length found.

     Time Complexity:
     O((n + m) * d), where `n` and `m` are the lengths of the arrays,
     and `d` is the maximum number of digits in a number.

     Space Complexity:
     O(n * d), for storing all prefixes from `arr1`.
     */
    func longestCommonPrefix(_ arr1: [Int], _ arr2: [Int]) -> Int {
        let prefixesFromFirstArray = buildPrefixSet(from: arr1)
        var longestPrefixLength = 0

        for number in arr2 {
            var currentPrefix = number

            // Remove one digit at a time until we find a prefix
            // that also exists in the first array.
            while currentPrefix > 0 {
                if prefixesFromFirstArray.contains(currentPrefix) {
                    longestPrefixLength = max(
                        longestPrefixLength,
                        digitCount(of: currentPrefix)
                    )

                    // Any smaller prefix of this number will be shorter,
                    // so we can stop checking this number.
                    break
                }

                currentPrefix /= 10
            }
        }

        return longestPrefixLength
    }

    // Builds a set of all numeric prefixes from the given numbers.
    // Example: 123 -> 123, 12, 1
    private func buildPrefixSet(from numbers: [Int]) -> Set<Int> {
        var prefixes = Set<Int>()

        for number in numbers {
            var currentPrefix = number

            while currentPrefix > 0 {
                prefixes.insert(currentPrefix)
                currentPrefix /= 10
            }
        }

        return prefixes
    }

    // Counts how many decimal digits are in the given positive number.
    private func digitCount(of number: Int) -> Int {
        var value = number
        var count = 0

        while value > 0 {
            count += 1
            value /= 10
        }

        return count
    }
}