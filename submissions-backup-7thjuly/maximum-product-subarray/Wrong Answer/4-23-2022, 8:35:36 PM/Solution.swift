// https://leetcode.com/problems/maximum-product-subarray

class Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        var maxProduct = Int.min
        
        var currentProduct = 1
        for currentNumber in nums {
            currentProduct *= currentNumber
            
            if currentProduct > maxProduct {
                maxProduct = currentProduct
            } else {
                currentProduct = 1
            }
            
            if currentProduct == 0 { currentProduct = 1 }
        }
        
        return maxProduct
    }
}