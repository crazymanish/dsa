// https://leetcode.com/problems/partition-labels

class Solution {
    func partitionLabels(_ s: String) -> [Int] {
        typealias LastIndex = Int
        var hashMap: [Character : LastIndex] = [:]
        
        var index = 0
        for char in s {
            hashMap[char] = index
            
            index += 1
        }
        
        var output: [Int] = []
        
        var currentPartitionLength = 0
        var currentPartitionEndIndex = 0
        var currentIndex = 0
        for char in s {
            let currentCharLastIndex = hashMap[char]!
            currentPartitionEndIndex = max(currentPartitionEndIndex, currentCharLastIndex)
            currentPartitionLength += 1
            
            if currentIndex == currentPartitionEndIndex {
                output.append(currentPartitionLength)
                currentPartitionLength = 0
            }
            
            currentIndex += 1
        }
        
        return output
    }
}