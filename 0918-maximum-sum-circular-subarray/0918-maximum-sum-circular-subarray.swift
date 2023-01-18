class Solution {
    /*
    This is based on the highest voted answer. Not my own.
    It is very interesting that we are able to calculate the circular by using non circular trick.

    The idea is to:
    1. Find the sum of all elements in the non circular array.
    2. Find out the max sub array sum in non circular array
    3. Find out the min sub array sum in non circular array
    The result is max(2, 1-3)
    
    There is edge case where all the elements are negative will return zero for (sum - min subarray sum). But we want the biggest negative value as the answer.
*/
    func maxSubarraySumCircular(_ nums: [Int]) -> Int {
        var maximum = -30000 // based on constraints
        var minimum = 30000 // based on constraints
        var sum = 0
        var partialMax = 0
        var partialMin = 0
        
        nums.forEach {
            partialMax = max(partialMax+$0, $0)
            partialMin = min(partialMin+$0, $0)
            maximum = max(maximum, partialMax)
            minimum = min(minimum, partialMin)
            sum += $0
        }
        
        if (sum == minimum) { return maximum }
        
        return max(maximum, sum-minimum)
    }
}