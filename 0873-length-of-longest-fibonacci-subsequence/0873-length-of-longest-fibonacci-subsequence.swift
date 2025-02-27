class Solution {
    func lenLongestFibSubseq(_ arr: [Int]) -> Int {
        // Dictionary to store the index of each element in arr
        let index: [Int: Int] = {
            var dict = [Int: Int]()
            for i in 0..<arr.count {
                dict[arr[i]] = i
            }
            return dict
        }()

        // 2D Dictionary to store the lengths of Fibonacci-like subsequences
        var longestFibSubseqLength = [Int: [Int: Int]]()
        var maxLength = 0

        // Iterate through each pair of elements in the array
        for i in 1..<arr.count {
            for j in 0..<i {
                let prev = arr[i] - arr[j] // Calculate the previous number in the Fibonacci-like subsequence
                if let k = index[prev], k < j { // Check if the previous number exists and its index is less than j
                    let currentLength = (longestFibSubseqLength[k]?[j] ?? 2) + 1 // Calculate the length of the current subsequence
                    longestFibSubseqLength[j, default: [:]][i] = currentLength // Store the length in the dp dictionary
                    maxLength = max(maxLength, currentLength) // Update maxLength if necessary
                }
            }
        }

        // If no Fibonacci-like subsequence is found, return 0
        return maxLength >= 3 ? maxLength : 0
    }
}