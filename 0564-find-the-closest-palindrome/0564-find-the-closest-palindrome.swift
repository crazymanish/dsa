class Solution {
    func nearestPalindromic(_ n: String) -> String {
        let len = n.count
        let i = len % 2 == 0 ? len / 2 - 1: len / 2;
        let left = Int(String(Array(n)[0...i]))!

        var candidate = [Int]()
        var even = false
        if(len % 2 == 0) { even = true }
        
        
        func getPalindrome(left:Int, even:Bool) -> Int {
            var left = left
            var res = left

            if (!even) { left = left / 10 }
    
            while (left > 0) {
                res = res * 10 + left % 10
                left /= 10
            }

            return res
        }

        let power_above = Int(truncating: pow(10, len) as NSDecimalNumber) //10000
        let power_below = Int(truncating: pow(10, len-1) as NSDecimalNumber) //10000
        candidate.append(getPalindrome(left:left, even:even)) // 12321
        candidate.append(getPalindrome(left:left+1, even:even)) // 12421
        candidate.append(getPalindrome(left:left-1, even:even)) // 12221
        candidate.append(power_below - 1); // 9999
        candidate.append(power_above + 1); // 100001

        var diff = Int.max
        var res = 0
        let nl = Int(n)!
        for cand in candidate {
            if (cand == nl) { continue }
            
            if (abs(cand - nl) < diff) {
                diff = abs(cand - nl)
                res = cand;
            } else if (abs(cand - nl) == diff) {
                res = min(res, cand)
            }
        }
        
        return String(res)
    }
} 