class Solution {
    func summaryRanges(_ nums: [Int]) -> [String] {
        var startingIndex = 0
        var ranges: [String] = []
        
        while startingIndex < nums.count {
            var endingIndex = startingIndex
            while endingIndex+1 < nums.count && nums[endingIndex]+1 == nums[endingIndex+1] {
                endingIndex += 1
            }
            
            if startingIndex == endingIndex {
                ranges.append("\(nums[startingIndex])")
            } else {
                ranges.append("\(nums[startingIndex])->\(nums[endingIndex])")
            }
            
            startingIndex = endingIndex+1
        }
        
        return ranges
    }
}