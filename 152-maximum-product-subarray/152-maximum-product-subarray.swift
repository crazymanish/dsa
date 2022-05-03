class Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        var maxProduct = Int.min
        
        /*
        Trick is: having odd or even numbers of negative integers. 
        if the negative numbers are even, then the first loop will give the solution. 
        If the negative numbers are odd, the second loop will give the solution.
        */
        
        var currentProduct = 1
        for currentNumber in nums {
            currentProduct *= currentNumber
            maxProduct = max(maxProduct, currentProduct)
            if currentProduct == 0 { currentProduct = 1 }
        }
        
        currentProduct = 1
        for currentNumber in nums.reversed() {
            currentProduct *= currentNumber
            maxProduct = max(maxProduct, currentProduct)
            if currentProduct == 0 { currentProduct = 1 }
        }
        
        return maxProduct
    }
}