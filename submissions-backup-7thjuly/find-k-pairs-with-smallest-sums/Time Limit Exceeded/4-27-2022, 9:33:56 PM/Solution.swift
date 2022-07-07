// https://leetcode.com/problems/find-k-pairs-with-smallest-sums

class Solution {
    func kSmallestPairs(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
        var hashMap: [Int: [[Int]]] = [:]
        var pairSums: [Int] = []
        
        for nums1Value in nums1 {
            for nums2Value in nums2 {
                let pairSum = nums1Value + nums2Value
                
                if let hashMapValue = hashMap[pairSum] {
                    hashMap[pairSum] = hashMapValue + [[nums1Value, nums2Value]]   
                } else {
                    hashMap[pairSum] = [[nums1Value, nums2Value]]
                    pairSums.append(pairSum)
                }
            }
        }
        
        pairSums = pairSums.sorted()
        
        var output: [[Int]] = []
        for pairSum in pairSums {
            let outputCount = output.count
            if outputCount == k { break }
            
            let pairs = hashMap[pairSum]!
            if outputCount + pairs.count <= k {
                output += pairs
            } else {
                let remainingCount = k-outputCount
                for index in 0..<remainingCount {
                    output.append(pairs[index])
                }
            }
        }
        
        return output
    }
}