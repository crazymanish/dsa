class Solution {
    func minimizeMax(_ nums: [Int], _ p: Int) -> Int {
        let numsCount = nums.count
        var sortedNums = nums.sorted()
        var left = 0 
        var right = sortedNums.last! - sortedNums.first!
    
        while left < right {
            let mid =  left + (right - left) / 2
            var pairsCount = 0
            var currentIndex = 1
            
            while currentIndex < numsCount {
                if sortedNums[currentIndex] - sortedNums[currentIndex-1] <= mid {
                    currentIndex += 1
                    pairsCount += 1
                }
                
                currentIndex += 1
            }
            
            if pairsCount >= p {
                right = mid
            } else {
                left = mid+1
            }
        }
        
        return left
    }
}