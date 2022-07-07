// https://leetcode.com/problems/beautiful-arrangement

class Solution {
    func countArrangement(_ n: Int) -> Int {
        var output = 0
        var nums = Array(repeating: 0, count: n+1)
        
        func backtracking(_ currentNum: Int) {
            if currentNum > n {
                output += 1
                return
            }
            
            for index in 1...n {
                if nums[index] == 0 && (currentNum%index == 0 || index%currentNum == 0) {
                    nums[index] = currentNum
                    backtracking(currentNum+1)
                    nums[index] = 0 // Reset for next backtracking call
                }
            }
        }
        
        backtracking(1)
        return output
    }
}