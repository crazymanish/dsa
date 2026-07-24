/**
 Problem Summary:
 Count the number of distinct XOR values obtainable from triplets
 (i, j, k), where indices may be reused.

 Strategy:
 1. Compute every possible XOR value from a pair of elements.
 2. Combine each pair XOR with every element.
 3. Use Boolean arrays to count each distinct triplet XOR once.

 Time Complexity:
 O(n² + n × 2ᴮ), where B is the number of bits required for the maximum value.

 Space Complexity:
 O(2ᴮ)
 */
class Solution {
    func uniqueXorTriplets(_ nums: [Int]) -> Int {
        let elementCount = nums.count
        let maximumValue = nums.max() ?? 0

        // XOR results fit within the next power-of-two bit range.
        var bitWidth = 1
        while (1 << bitWidth) <= maximumValue {
            bitWidth += 1
        }

        let xorValueCount = 1 << bitWidth

        // Record every XOR value obtainable from a pair (i, j), where i <= j.
        var pairXorExists = [Bool](repeating: false, count: xorValueCount)

        for firstIndex in 0..<elementCount {
            for secondIndex in firstIndex..<elementCount {
                let pairXor = nums[firstIndex] ^ nums[secondIndex]
                pairXorExists[pairXor] = true
            }
        }

        // Combine each distinct pair XOR with every element to form triplets.
        var tripletXorExists = [Bool](repeating: false, count: xorValueCount)
        var distinctTripletCount = 0

        for pairXor in 0..<xorValueCount where pairXorExists[pairXor] {
            for value in nums {
                let tripletXor = pairXor ^ value

                // Count each resulting XOR value only once.
                if !tripletXorExists[tripletXor] {
                    tripletXorExists[tripletXor] = true
                    distinctTripletCount += 1
                }
            }
        }

        return distinctTripletCount
    }
}