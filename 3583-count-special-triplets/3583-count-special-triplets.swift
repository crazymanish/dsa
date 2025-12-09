/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n), where n = nums.count  
///     We process each element once, and all dictionary operations are O(1) average.
///
/// Space Complexity:
///   • O(n)
///     Two hash maps store frequencies of values encountered so far (left side)
///     and values yet to be processed (right side).
///
/// Explanation:
///   A special triplet (i, j, k) satisfies:
///        nums[i] + nums[k] = 2 * nums[j]
///   which means nums[j] must be the midpoint.
///
///   For each element nums[j]:
///       - leftFreq[x] = how many times x appears before j
///       - rightFreq[x] = how many times x appears after j
///
///   We check:
///       leftFreq[2 * nums[j]] * rightFreq[2 * nums[j]]
///   This counts all i < j < k such that:
///       nums[i] = nums[k] = 2 * nums[j]
/// ---------------------------------------------------------------------------
class Solution {
    func specialTriplets(_ nums: [Int]) -> Int {
        let MOD = Int(1e9) + 7
        
        // Count all frequencies for elements that appear to the RIGHT of index j
        var rightFreq = [Int: Int]()
        // Count frequencies for elements already seen to the LEFT of index j
        var leftFreq = [Int: Int]()
        
        for value in nums {
            rightFreq[value, default: 0] += 1
        }
        
        var tripletCount = 0
        
        for midValue in nums {     // Treat each element as nums[j]
            // This element moves from right side to left side
            rightFreq[midValue]! -= 1
            
            let target = midValue * 2  // We need nums[i] = nums[k] = target
            
            // Count matching pairs:
            //   #left occurrences of target  ×  #right occurrences of target
            let leftMatches = leftFreq[target, default: 0]
            let rightMatches = rightFreq[target, default: 0]
            
            tripletCount = (tripletCount + leftMatches * rightMatches) % MOD
            
            // Now midValue becomes available for roles where j' > j
            leftFreq[midValue, default: 0] += 1
        }
        
        return tripletCount
    }
}
