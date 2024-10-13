class Solution {
    func smallestRange(_ nums: [[Int]]) -> [Int] {
        var indices = Array(repeating: 0, count: nums.count)
        var range = [0,Int.max]
        
        while true {
            var (curMin, curMax) = (Int.max,Int.min)
            var minIndex = 0
            
            for (i,j) in zip(nums.indices, indices) {
                let num = nums[i][j]
                (curMin, curMax) = (min(curMin, num), max(curMax, num))
                minIndex = num == curMin ? i : minIndex
            }
            
            indices[minIndex] += 1

            if curMax-curMin < range[1]-range[0] {
                range = [curMin, curMax]
            }
            
            guard indices[minIndex] < nums[minIndex].count else { return range }
        }
    }
}