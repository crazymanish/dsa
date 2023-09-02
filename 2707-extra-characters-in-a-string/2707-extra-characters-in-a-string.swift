class Solution {
    func minExtraChar(_ s: String, _ dictionary: [String]) -> Int {
        var map = [String: Bool]()
        for i in 0..<dictionary.count {
            map[dictionary[i]] = true
        }
        
        var dp = Array(repeating: -1, count: s.count)
        var arr = Array(s)
        
        func calculateMinExtraChar(_ index:Int) -> Int{
            if index >= arr.count { return 0 }
            
            if dp[index] != -1 { return dp[index] }
            
            var curr = ""
            var length = arr.count
            
            for i in index..<arr.count {
                curr.append(String(arr[i]))
                var count = curr.count
                if map[curr] == true {
                    count = 0
                }
            
                count += calculateMinExtraChar(i+1)
                length = min(length, count)
            }
            
            dp[index] = length
            return dp[index]
        }
    
        return calculateMinExtraChar(0)
    }
}