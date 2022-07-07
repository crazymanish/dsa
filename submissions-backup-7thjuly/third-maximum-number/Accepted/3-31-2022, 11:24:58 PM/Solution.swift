// https://leetcode.com/problems/third-maximum-number

class Solution {
    func thirdMax(_ nums: [Int]) -> Int {
        if nums.isEmpty { return 0 }
        
        var set: Set<Int> = []
        
        for num in nums { set.insert(num) }
        
        let array = Array(set.sorted { $0 > $1 })
        
        print(array)
        
        if array.count < 3 {
            return array.first!
        } else {
            return array[2]
        }
    }
}