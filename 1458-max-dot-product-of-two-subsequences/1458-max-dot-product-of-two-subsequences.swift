class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(m * n)
    ///     - m = firstArray.count
    ///     - n = secondArray.count
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     - Only one DP row of size (n + 1) is stored.
    /// -----------------------------------------------------------------------
    func maxDotProduct(_ firstArray: [Int], _ secondArray: [Int]) -> Int {
        // Ensure the second array is the shorter one to minimize space usage
        if firstArray.count < secondArray.count {
            return maxDotProduct(secondArray, firstArray)
        }
        
        let shorterLength = secondArray.count
        
        // Sentinel value smaller than any valid dot product
        let negativeInfinity = -1_000_001
        
        // dpPrevious[j] = max dot product using:
        //   firstArray[0..<i-1] and secondArray[0..<j]
        var dpPrevious = Array(repeating: negativeInfinity, count: shorterLength + 1)
        
        // Iterate over elements of the longer array
        for firstIndex in 1...firstArray.count {
            
            // dpCurrent[j] = max dot product using:
            //   firstArray[0..<firstIndex] and secondArray[0..<j]
            var dpCurrent = Array(repeating: 0, count: shorterLength + 1)
            dpCurrent[0] = negativeInfinity
            
            for secondIndex in 1...shorterLength {
                // Option 1: skip one element (do not form a pair here)
                let skipCurrentPair =
                    max(dpPrevious[secondIndex],
                        dpCurrent[secondIndex - 1])
                
                // Option 2: take current elements as a pair
                let takeCurrentPair =
                    max(dpPrevious[secondIndex - 1], 0) +
                    firstArray[firstIndex - 1] * secondArray[secondIndex - 1]
                
                // Best result up to these indices
                dpCurrent[secondIndex] = max(skipCurrentPair, takeCurrentPair)
            }
            
            // Move to the next iteration
            dpPrevious = dpCurrent
        }
        
        // Final answer is the DP value using all elements
        return dpPrevious[shorterLength]
    }
}
