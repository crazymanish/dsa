class Solution {
    func minimumFuelCost(_ roads: [[Int]], _ seats: Int) -> Int {
        var answer = 0
        var graph = [[Int]](repeating: [Int](), count: roads.count + 1)
        for road in roads {
            graph[road[0]].append(road[1])
            graph[road[1]].append(road[0])
        }
        
        func dfs(_ current: Int, _ previous: Int) -> Int {
            var people = 1
            for next in graph[current] {
                if next == previous { continue }
                people += dfs(next, current)
            }
            
            if current != 0 { answer += (people + seats - 1) / seats }
            return people
        }
        
        dfs(0, 0)
        return answer
    }
}