class Solution {
    func maximumRequests(_ n: Int, _ requests: [[Int]]) -> Int {
        var degree = [Int](repeating: 0, count: n)
        
        func dfs(_ i: Int) -> Int {
            guard i != requests.count else { 
                return degree.filter{ $0 == 0 }.count == n ? 0 : Int.min
            }
            
            degree[requests[i][0]] -= 1
            degree[requests[i][1]] += 1
            
            let take = 1 + dfs(i+1)
            degree[requests[i][0]] += 1
            degree[requests[i][1]] -= 1
            
            return max(take, dfs(i+1))
        }
        
        return dfs(0)
    }
}