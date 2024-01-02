class Solution {
    // Approach: Count frequency of each element , and append it in the 2D array column wise.
    func findMatrix(_ nums: [Int]) -> [[Int]] {
        var frequencyCountDict = [Int: Int]()
        var maxRows = 0
        
        for number in nums {
            frequencyCountDict[number, default: 0] += 1
            maxRows = max(maxRows, frequencyCountDict[number, default: 0])
        }

        var answer: [[Int]] = Array(repeating: [], count: maxRows)
        for (key, value) in frequencyCountDict {
            for index in 0..<value {
                answer[index].append(key)
            }
        }
        
        return answer
    }
}