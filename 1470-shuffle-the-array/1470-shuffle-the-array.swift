class Solution {
    func shuffle(_ nums: [Int], _ n: Int) -> [Int] {
        var shuffledArray: [Int] = []
        
        for index in 0..<nums.count / 2 {
            shuffledArray.append(nums[index])
            shuffledArray.append(nums[n+index])
        }
        
        return shuffledArray
    }
}