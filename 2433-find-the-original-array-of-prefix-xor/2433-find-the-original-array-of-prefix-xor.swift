class Solution {
    func findArray(_ pref: [Int]) -> [Int] {
        var results = [Int](repeating: 0, count: pref.count)
        results[0] = pref[0]
        
        for i in 1..<results.count {
            results[i] = pref[i] ^ pref[i-1]
        }
        
        return results
    }
}