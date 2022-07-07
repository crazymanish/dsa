// https://leetcode.com/problems/maximum-product-subarray

class Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        var maxProduct = nums[0]
        
        var currentProduct = 1
        for num in nums {
            if currentProduct < 0 { currentProduct = 1 } // Reset if negative
            currentProduct *= num
            
            maxProduct = max(maxProduct, currentProduct)
        }
        
        return maxProduct
    }
}