class Solution {
    /*
    The key to this problem is to understand that the max value of the array
    is the max of the sum of the array divided by the length of the array
    and each element of the array divided by 1. To find the max of the sum
    of the array divided by the length of the array and each element of the
    array divided by 1, we find the sum of the array and then find the max
    value of (sum + index) / (index + 1) 
    */
    func minimizeArrayValue(_ A: [Int]) -> Int {
        var sum = 0 
        var maxValue = 0
        
        for index in 0..<A.count {
            sum += A[index]
            
            let currentValue = (sum + index) / (index + 1)
            maxValue = max(maxValue, currentValue)
        }
        
        return maxValue
    }
}