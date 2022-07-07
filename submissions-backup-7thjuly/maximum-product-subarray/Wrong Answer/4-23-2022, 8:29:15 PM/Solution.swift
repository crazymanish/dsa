// https://leetcode.com/problems/maximum-product-subarray

class Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        var maxProduct = nums[0]
        
        var currentProduct = 0
        for currentNumber in nums {
            if currentNumber < 0 { // Reset if negative
                currentProduct = 0
                maxProduct = max(maxProduct, currentProduct)
                continue
            } else if currentProduct == 0 {
                currentProduct = 1
            }
            
            currentProduct *= currentNumber
            maxProduct = max(maxProduct, currentProduct)
        }
        
        return maxProduct
    }
}