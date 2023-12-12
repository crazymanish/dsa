class Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        let numsCount = nums.count
        let sortedNums = nums.sorted()
        
        return (sortedNums[numsCount-1]-1) * (sortedNums[numsCount-2]-1)
    }
}