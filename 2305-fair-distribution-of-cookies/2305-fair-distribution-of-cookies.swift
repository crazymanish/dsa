class Solution {
    func distributeCookies(_ cookies: [Int], _ k: Int) -> Int {
        let n = cookies.count
        var answer = Int.max
        var children = Array(repeating: 0, count: k)
        
        func backtracking(_ cookieId: Int) {
            if cookieId == n {
                answer = min(answer, children.max()!)
                return
            }
            
            for i in 0..<k {
                children[i] += cookies[cookieId] 
                backtracking(cookieId+1)
                children[i] -= cookies[cookieId]
            }
        }
        
        backtracking(0)
        return answer
    }
}