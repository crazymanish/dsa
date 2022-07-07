// https://leetcode.com/problems/partition-array-for-maximum-sum

class Solution {
    func maxSumAfterPartitioning(_ arr: [Int], _ k: Int) -> Int {
        var dpCache: [Int] = []
        dpCache.append(0)
        
        for (index, element) in arr.enumerated() {
            var maxElement = Int.min
            var maxSum = Int.min
            
            var kIndex = 0
            while kIndex < k && index-kIndex >= 0 {
                maxElement = max(maxElement, arr[index-kIndex])
                
                let maxElementSum = maxElement*(kIndex+1)
                let currentSum = dpCache[index-kIndex]+maxElementSum
                maxSum = max(maxSum, currentSum)
                
                kIndex += 1
            }
            
            dpCache.append(maxSum)
        }
        
        return dpCache.last!
    }
}