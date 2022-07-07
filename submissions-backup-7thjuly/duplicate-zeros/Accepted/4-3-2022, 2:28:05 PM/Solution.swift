// https://leetcode.com/problems/duplicate-zeros

class Solution {
    func duplicateZeros(_ arr: inout [Int]) {
        var index = 0
        
        while index < arr.count {
            let value = arr[index]
            
            if value == 0 {
                arr.removeLast()
                arr.insert(value, at: index)
                index += 1
            }
            
            index += 1
        }
    }
}