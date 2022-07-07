// https://leetcode.com/problems/flipping-an-image

class Solution {
    func flipAndInvertImage(_ image: [[Int]]) -> [[Int]] {
        var inputArray = image
        let imageCount = inputArray.count
        
        for i in 0..<imageCount {
            inputArray[i] = Array(inputArray[i].reversed())
            
            for j in 0..<imageCount {
                inputArray[i][j] = 1 - inputArray[i][j]
            }
        }
        
        return inputArray
    }
}