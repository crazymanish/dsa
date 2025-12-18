/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n * k)
///     - For each possible window of size k, we compute its gain in O(k).
///     - There are (n - k + 1) such windows.
///
/// Space Complexity:
///   • O(1)
///     - Only constant extra variables are used.
///
/// Problem Interpretation:
///   - `strategy[i]` indicates whether we currently apply the strategy on day i.
///   - Original profit = sum(strategy[i] * prices[i]).
///   - We are allowed to choose ONE continuous segment of length k and
///     override the strategy:
///       • First k/2 days → force strategy = 0
///       • Last  k/2 days → force strategy = 1
///
///   We compute the maximum additional gain achievable by replacing the
///   strategy on any such segment and add it to the original profit.
/// ---------------------------------------------------------------------------

class Solution {
    func maxProfit(_ prices: [Int], _ strategy: [Int], _ k: Int) -> Int {
        let n = prices.count
        let halfWindow = k / 2
        
        // Step 1: Compute original profit with the given strategy
        var baseProfit = 0
        for i in 0..<n {
            baseProfit += strategy[i] * prices[i]
        }
        
        // Step 2: Try replacing each window of length k
        var maxExtraGain = 0
        
        for start in 0...(n - k) {
            var windowGain = 0
            
            // Gain from forcing strategy = 1 in the second half of the window
            for index in (start + halfWindow)..<(start + k) {
                windowGain += prices[index]
            }
            
            // Subtract the original strategy contribution over the whole window
            for index in start..<(start + k) {
                windowGain -= strategy[index] * prices[index]
            }
            
            maxExtraGain = max(maxExtraGain, windowGain)
        }
        
        // Final result = original profit + best improvement
        return baseProfit + maxExtraGain
    }
}
