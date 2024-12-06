class Solution {
    func maxCount(_ banned: [Int], _ n: Int, _ maxSum: Int) -> Int {
        let banned = Set(banned)
		var currentSum = 0
        var count = 0
		
        for i in 1 ... n where !banned.contains(i) {
            guard currentSum + i <= maxSum else { break }
            
            currentSum += i
            count += 1
        }
        
        return count
    }
}