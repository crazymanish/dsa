class Solution {
    func numberOfMatches(_ n: Int) -> Int {
        if n <= 1 { return 0 }
        var answer = 0
        
        if n % 2 == 0 {
            answer += (n / 2) + numberOfMatches(n / 2)
        } else {
            answer += ((n - 1) / 2) + numberOfMatches((n - 1) / 2 + 1)
        }
        
        return answer
    }
}