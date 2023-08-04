/*
- note: you need to account for wordDict containing words that are subsets of one other which could lead to false negatives
- therefore, perhaps DP would be a good option here
- dp[i] = whether s[0 ..< i] can be segmented using wordDict (true / false)
- dp[i] = true, if dp[j] == true && s[j ..< i] is inside wordDict, j < i
- base case: dp[0] = true (i.e., an empty string can be successfully segmented using wordDict)

- ~ O(s.count * wordDict.count) time
- ~ O(s.count) space
*/
class Solution {
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        var dp = [Bool](repeating: false, count: s.count + 1)
        dp[0] = true
        let sArray = Array(s)
        
        for index in 0...s.count {
            if dp[index] == false { continue }
            
            for word in wordDict {
                let endIndex = index + word.count
                
                guard endIndex <= s.count else { continue }
                
                let tmpWord = String(sArray[index..<endIndex])
                if tmpWord == word {
                    dp[endIndex] = true
                }
            }
        }
        
        return dp[s.count]
    }
}