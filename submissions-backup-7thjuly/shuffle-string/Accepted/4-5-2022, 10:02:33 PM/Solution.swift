// https://leetcode.com/problems/shuffle-string

class Solution {
    func restoreString(_ s: String, _ indices: [Int]) -> String {
        let sCount = s.count
        let sArray = Array(s)
        var output = Array(repeating: "", count: sCount)
        
        for i in 0..<sCount {
            let index = indices[i]
            output[index] = String(sArray[i])
        }
        
        return output.joined()
    }
}