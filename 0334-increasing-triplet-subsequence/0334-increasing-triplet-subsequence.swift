class Solution {
    func increasingTriplet(_ nums: [Int]) -> Bool {
        var firstNumber = Int.max
        var secondNumber = Int.max
        
        for currentNumber in nums {
            if currentNumber > secondNumber {
                return true
            } else if currentNumber > firstNumber {
                secondNumber = min(secondNumber, currentNumber)
            } else {
                firstNumber = min(firstNumber, currentNumber)
            }
        }
        
        return false
    }
}