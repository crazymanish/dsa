class Solution {
    func minimumMountainRemovals(_ nums: [Int]) -> Int {
        var dp1 = Array(repeating: 1, count: nums.count)
        var dp2 = Array(repeating: 1, count: nums.count)
    
        func BitonicSubsequence() -> Int {
            var maxi = 0
            for i in 0..<nums.count{
                for prev in 0..<i{
                    if nums[i] > nums[prev] && dp1[i] < 1 + dp1[prev]{
                        dp1[i] = 1 + dp1[prev]
                    }
                }
            }
    
            for i in (0..<nums.count).reversed(){
                for prev in (i+1..<nums.count).reversed(){
                    if nums[i] > nums[prev] && dp2[i] < 1 + dp2[prev]{
                        dp2[i] = 1 + dp2[prev]
                    }
                }
                
                if dp1[i] > 1 && dp2[i] > 1 {
                    maxi = max(maxi, dp1[i] + dp2[i] - 1)
                }
            }

            return nums.count - maxi
        }

        return BitonicSubsequence()
    }
}