class Solution {
    func rotateString(_ s: String, _ goal: String) -> Bool {
        if s.isEmpty { return s == goal }
        
        if s.count != goal.count { return false }
        
        return (s + s).contains(goal) // abcdeabcde will contain bcdea
    }
}

/*
class Solution {
    // Time: O(n)
    // Space: O(n)
    func rotateString(_ s: String, _ goal: String) -> Bool {
        let arrS = Array(Array(s) + Array(s))
        let arrG = Array(goal)
        
        if arrS.count / 2 != arrG.count { 
            return false 
        }
        
        var j = 0
        for i in 0..<arrS.count {
            if arrS[i] == arrG[j] {
                j += 1
                if j == arrG.count { return true }
            } else {
                j = 0
                if arrS[i] == arrG[j] {
                    j += 1
                }
            }
        }
        return false
    }
}
*/