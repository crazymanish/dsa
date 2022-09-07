class Solution {
    func sortArrayByParityII(_ nums: [Int]) -> [Int] {
        var sortedArray = Array(repeating:0, count:nums.count)
        // Using two pointers
        var evenCounter = 0
        var oddCounter = 1
        
        for num in nums {
            if num%2 == 0 {
                sortedArray[evenCounter] = num
                evenCounter += 2
            } else {
                sortedArray[oddCounter] = num
                oddCounter += 2
            }
        }
        
        
        return sortedArray
    }
}