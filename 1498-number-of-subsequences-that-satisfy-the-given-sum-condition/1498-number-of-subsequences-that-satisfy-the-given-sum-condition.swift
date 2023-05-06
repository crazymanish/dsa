class Solution {
    /*
    https://github.com/stevencurtis/SwiftCoding/tree/master/LeetCode/Contests/195
    Here the given sum condition is that the sum of the minimum and maximum element are less or equal than the target.
    The question tells us that we should return the result modulo 10^9 + 7, which here I've coded as let MOD = 1000000007.
    This heart of the can be calculated with the following code snippet that precomputes 2^n (which is important as n can be large in this question): var powPreComp = Array(repeating: 0, count: nums.count + 1) powPreComp[0] = 1 for i in 1..<nums.count { powPreComp[i] = 2 * powPreComp[i - 1] % MOD } which results in the array powPreComp containing: [1, 2, 4, 8, 16, 32, 64, ...]
    We don't care about the order of the elements - only them minimum and maximum within that sub array. Therefore effectively [1 2 3] = [2 3 1] = [ 3 2 1] = [3 1 2] = [2 1 3].

    I've gone for Swift's internal sort here
    let sortedNums = nums.sorted()
    Now we can use a two-pointer solution to find the maxium array length with the answer - and keep moving that left pointer until the pointers cross. The solution is as follows:
    */
    func numSubseq(_ nums: [Int], _ target: Int) -> Int {
        let MOD = 1000000007
        var result = 0
        
        // calculate the number of subsequences in an array of length i
        // which is 2 to the power of the length
        var precomputedNums = Array(repeating: 0, count: nums.count + 1)
        precomputedNums[0] = 1
        for i in 1..<nums.count {
            precomputedNums[i] = 2 * precomputedNums[i-1] % MOD
        }

        // sort the array
        let sortedNums = nums.sorted()
        
        // set the lowest point and the highest point as the longest possible subarray
        var low = 0
        var high = nums.count-1
        
        while low <= high {
            let total = sortedNums[low] + sortedNums[high]
            
            if total > target {
                high -= 1
            } else {
                result += precomputedNums[high-low]
                low += 1
            }
        }
        
        return result % MOD
    }
}