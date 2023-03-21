class Solution {
    /*
    Approach: For each window we count the number of zeros and add it up to the result variable. When the window ends (num == 1) we reset the count number, but keep the result
    */
    func zeroFilledSubarray(_ nums: [Int]) -> Int {
        var subArrayCount = 0
        var result = 0

        for num in nums {
            guard num == 0 else { 
                subArrayCount = 0 
                continue
            }
            
            subArrayCount += 1
            result += subArrayCount
        }
        
        return result
    }
}