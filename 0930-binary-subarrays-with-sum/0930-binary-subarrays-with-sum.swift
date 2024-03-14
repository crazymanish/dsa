class Solution {
    func numSubarraysWithSum(_ nums: [Int], _ goal: Int) -> Int {
        var result = 0 // result
        var sum = 0 // current prefix sum
        var sumFreq: [Int: Int] = [:] // frequencies of prefix sums, [prefix sum : number of occurrences]
        
        for num in nums {
            sum += num
            
            if sum == goal { result += 1 }
            
            // if there are prefix sum with value `sum - goal`,
            // then the sequence after it sums to 'goal'
            result += sumFreq[sum - goal, default: 0]            
            sumFreq[sum, default: 0] += 1
        }
        
        return result
    }
}