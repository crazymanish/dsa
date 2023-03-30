class Solution {
    func isScramble(_ s1String: String, _ s2String: String) -> Bool {
        let asciiA = Character("a").asciiValue!
        var cache = [[[[Bool?]]]]()
        var s1 = [Character]()
        var s2 = [Character]()
    
        func dfs(_ s1s: Int, _ s1e: Int, _ s2s: Int, _ s2e: Int) -> Bool {
            if let val = cache[s1s][s1e][s2s][s2e] { return val }
        
            var res = true
            if s1[s1s...s1e] == s2[s2s...s2e] { 
                res = true
            } else {
                var arr = Array(repeating: 0, count: 26)
                let len = s1e - s1s
                for i in 0...len {
                    arr[Int(s1[s1s+i].asciiValue! - asciiA)] += 1
                    arr[Int(s2[s2s+i].asciiValue! - asciiA)] -= 1
                }

                for i in 0..<26 {
                    if arr[i] != 0 {
                        res = false
                        break
                    }
                }
            
                if res {
                    var temp = false
                
                    for i in 1...len {
                        if dfs(s1s, s1s+i-1, s2s, s2s+i-1) && dfs(s1s+i, s1e, s2s+i, s2e) {
                            temp = true
                            break
                        }
                    
                        if dfs(s1s, s1s+i-1, s2e-i+1, s2e) && dfs(s1s+i, s1e, s2s, s2e-i) {
                            temp = true
                            break
                        }
                    }
                
                    if !temp {
                        res = false
                    }
                }
            }
        
            cache[s1s][s1e][s2s][s2e] = res
            return res
        }
        
        let n = s1String.count
        cache = Array(repeating: Array(repeating: Array(repeating: Array(repeating: nil, count: n), count: n), count: n), count: n)
        
        s1 = Array(s1String)
        s2 = Array(s2String)
        
        return dfs(0, n-1, 0, n-1)
    }
}


/*
class Solution {
    func isScramble(_ s1: String, _ s2: String) -> Bool {
        if s1.isEmpty && s2.isEmpty { return false }
        if s1 == s2 { return true }
        
        func hasSameLetters() -> Bool {
            var map1 = [Character: Int]()
            var map2 = [Character: Int]()
        
            for char in s1 {
                map1[char, default: 0] += 1
            }
        
            for char in s2 {
                map2[char, default: 0] += 1
            }
            
            return map1 == map2
        }
        
        guard hasSameLetters() else { return false }
        
        let s1 = Array(s1), s2 = Array(s2), len = s1.count
        
        for i in 1..<len {
            let s1LTR = (left: String(s1[0..<i]),     right: String(s1[i..<len]))
            let s2LTR = (left: String(s2[0..<i]),     right: String(s2[i..<len]))
            let s2RTL = (left: String(s2[0..<len-i]), right: String(s2[len-i..<len]))
            
            if isScramble(s1LTR.left, s2LTR.left) && isScramble(s1LTR.right, s2LTR.right) {
                return true
            }
            if isScramble(s1LTR.left, s2RTL.right) && isScramble(s1LTR.right, s2RTL.left) {
                return true
            }
        }
        
        return false
    }
}
*/