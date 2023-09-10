class Solution {
    func countOrders(_ n: Int) -> Int {
        var dict = [[Int]: Int]()
        
        func dfs(_ unpicked: Int, _ undelivered: Int) -> Int {
            if dict[[unpicked, undelivered]] != nil { return dict[[unpicked, undelivered]]! }
            
            if unpicked == 0 && undelivered == 0 { return 1 }
            
            if unpicked < 0 || undelivered < 0 || unpicked > undelivered { return 0 }
            
            var result = unpicked * dfs(unpicked-1, undelivered)
            result %= Int(1E9 + 7)
            
            result += (undelivered-unpicked) * dfs(unpicked, undelivered-1)
            result %= Int(1E9 + 7)
            
            dict[[unpicked, undelivered]] = result
            return result
        }

        return dfs(n,n)   
    }
}