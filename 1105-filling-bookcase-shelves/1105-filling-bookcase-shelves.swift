class Solution {
    func minHeightShelves(_ books: [[Int]], _ shelfWidth: Int) -> Int {
        let n = books.count
        var dp = [Int](repeating: Int.max, count: n + 1)
        dp[0] = 0
        
        for i in 1...n {
            var width = 0
            var height = 0
            for j in stride(from: i, through: 1, by: -1) {
                width += books[j-1][0]
                if width > shelfWidth {
                    break
                }
                height = max(height, books[j-1][1])
                dp[i] = min(dp[i], dp[j-1] + height)
            }
        }
        
        return dp[n]
    }
}