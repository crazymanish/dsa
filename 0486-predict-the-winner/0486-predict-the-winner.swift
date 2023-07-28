class Solution {
    func PredictTheWinner(_ nums: [Int]) -> Bool {
        let count = nums.count
        let mode = 100
        var dp = [Int: Bool]()
        
        func predict(_ isPlayer1Winner: Bool, _ sum: Int, _ left: Int, _ right: Int) -> Bool {
            let key = sum * mode * mode + left * mode + right
            if let cacheValue = dp[key] { return cacheValue }
            
            var result = false
            if left == right {
                result = isPlayer1Winner ? (nums[left]-sum >= 0) : (nums[left]-sum > 0)
            } else { // left < right
                let leftResult = predict(!isPlayer1Winner, nums[left]-sum, left+1, right)
                let rightResult = predict(!isPlayer1Winner, nums[right]-sum, left, right-1)
                
                result = !leftResult || !rightResult
            }
            
            dp[key] = result
            return result
        }
        
        return predict(true, 0, 0, count-1)
    }
}