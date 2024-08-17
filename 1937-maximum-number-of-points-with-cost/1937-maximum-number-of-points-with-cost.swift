class Solution {
    func maxPoints(_ points: [[Int]]) -> Int {
        points[1...].reduce(into: points[0]) { dp, row in
			// bi-directional sweep to find max points of prev row
            for l in 1..<row.count {
                let r = row.count-1-l
                dp[l] = max(dp[l], dp[l-1]-1)
                dp[r] = max(dp[r], dp[r+1]-1)
            }
			// add current row values into dp
            dp = zip(dp,row).map(+)
        }
        .max()!
    }
}