class Solution {
    func divideArray(_ nums: [Int]) -> Bool {
        guard nums.count % 2 == 0 else { return false } // Early exit if odd number of elements

        var counts: [Int: Int] = [:] // Dictionary to store element counts

        for num in nums {
            counts[num, default: 0] += 1 // Increment count for each number
        }

        for count in counts.values {
            if count % 2 != 0 { // Check if any count is odd
                return false // If any count is odd, pairing is impossible
            }
        }

        return true // All counts are even, pairing is possible
    }
}