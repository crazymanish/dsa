// https://leetcode.com/problems/rank-transform-of-an-array

class Solution {
    func arrayRankTransform(_ array: [Int]) -> [Int] {
        let sortedArray = array.sorted()
        
        var hashMap: [Int : Int] = [:]
        
        var currentRank = 1
        for element in sortedArray {
            if hashMap[element] == nil {
                hashMap[element] = currentRank
                currentRank += 1
            }
        }
        
        var outputArray: [Int] = []
        for element in array {
            outputArray.append(hashMap[element]!)
        }
        
        return outputArray
    }
}