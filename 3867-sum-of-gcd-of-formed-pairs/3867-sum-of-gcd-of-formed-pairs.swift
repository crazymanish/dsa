class Solution {
    /**
     Problem Summary:
     Given an array of integers, compute the GCD of each element with the maximum
     value seen so far, sort those GCD values, then repeatedly pair the smallest
     and largest values and accumulate their GCD.

     Strategy:
     1. Traverse the array while maintaining the running maximum.
     2. Compute the GCD of the current number and the running maximum.
     3. Sort the resulting GCD values.
     4. Use two pointers to pair the smallest and largest values and sum their GCDs.

     Time Complexity:
     O(n log n)
     - O(n) to build the GCD array.
     - O(n log n) to sort.
     - O(n) for the two-pointer traversal.

     Space Complexity:
     O(n)
     - Stores the intermediate GCD values.
     */
    func gcdSum(_ nums: [Int]) -> Int {
        var runningMaximum = 0
        var gcdValues: [Int] = []

        // Build the list of GCDs with the maximum value seen so far.
        for number in nums {
            runningMaximum = max(runningMaximum, number)
            gcdValues.append(gcd(number, runningMaximum))
        }

        // Sort to enable smallest-largest pairing.
        gcdValues.sort()

        var left = 0
        var right = gcdValues.count - 1
        var totalGcdSum = 0

        // Pair the smallest and largest remaining values.
        while left < right {
            totalGcdSum += gcd(gcdValues[left], gcdValues[right])
            left += 1
            right -= 1
        }

        return totalGcdSum
    }

    /// Computes the Greatest Common Divisor using the iterative Euclidean algorithm.
    private func gcd(_ first: Int, _ second: Int) -> Int {
        var first = first
        var second = second

        while second != 0 {
            let remainder = first % second
            first = second
            second = remainder
        }

        return first
    }
}