class Solution {
    func canSortArray(_ nums: [Int]) -> Bool {
        let sorted = nums.sorted()
        var groups = [[Int]]()
        var count = nums[0].bitCount()
        var group = [nums[0]]
        
        for i in 1..<nums.count {
            let bitCount = nums[i].bitCount()
            if count == bitCount {
                group.append(nums[i])
            } else {
                groups.append(group)
                group = [nums[i]]
                count = bitCount
            }
        }
        groups.append(group)
        
        let arr = Array(groups.map {$0.sorted()}.joined(separator: []))
        return arr == sorted
    }
}

extension Int {
    func bitCount() -> Int {
        var cur = self
        var count = 0
        while cur > 0 {
            count += cur % 2
            cur = cur / 2
        }
        return count
    }
}