class Solution {
    func maxValueOfCoins(_ piles: [[Int]], _ k: Int) -> Int {
        var dpCache = Array(repeating: Array(repeating: -1, count: k + 1), count: piles.count + 1)
        
        func calculateMaxValue(_ currentIndex: Int, _ currentK: Int) -> Int {
            if currentK == 0 || currentIndex == piles.count { return 0 }
            
            if dpCache[currentIndex][currentK] != -1 { return dpCache[currentIndex][currentK] }

            var maxValue = calculateMaxValue(currentIndex+1, currentK)
            var currentValue = 0

            for j in 0..<min(piles[currentIndex].count, currentK) {
                currentValue += piles[currentIndex][j]
                maxValue = max(maxValue, currentValue + calculateMaxValue(currentIndex+1, currentK-j-1))
            }
            
            dpCache[currentIndex][currentK] = maxValue
            return maxValue
        }
        
        return calculateMaxValue(0, k)
    }
}