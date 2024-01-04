class Solution {
    func minOperations(_ nums: [Int]) -> Int {
        var numCountDict = [Int: Int]()
        nums.forEach { numCountDict[$0, default: 0] += 1 }
        
        var operationCount = 0
        for (_, value) in numCountDict {
            guard value != 1 else { return -1 }
            
            let mod = value % 3
            let div = value / 3
            operationCount += div + (mod > 0 ? 1 : 0)
        }
        
        return operationCount
    }
}