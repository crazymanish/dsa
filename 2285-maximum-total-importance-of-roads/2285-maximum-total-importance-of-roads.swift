class Solution {
    func maximumImportance(_ n: Int, _ roads: [[Int]]) -> Int {
        var outDegree = Array(repeating: 0, count: n)
        
        for road in roads {
            let u = road[0], v = road[1]
            outDegree[u] += 1 
            outDegree[v] += 1
        }
    
        outDegree.sort()
    
        var result = 0
        for i in 1...n {
            result += outDegree[i-1] * i
        }
    
        return result
    }
}