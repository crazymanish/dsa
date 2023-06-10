class Solution {
    func maxValue(_ n: Int, _ index: Int, _ maxSum: Int) -> Int {
        var result = 2
        var currentSum = n+1
        let endIndex = n-index-1
        
        while currentSum <= maxSum {
            result += 1
            currentSum += 1 + min(result-2, index) + min(result-2, endIndex)
            
            if (result-2 >= index) && (result-2 >= endIndex) { break }
        }
        
        if currentSum > maxSum { return result - 1 }
        
        return result + (maxSum-currentSum) / n
    }
}