class Solution {
    func largestPathValue(_ colors: String, _ edges: [[Int]]) -> Int {
        var graph = [Int: [Int]]()
        
        var inbound = Array(repeating: 0, count: colors.count)
        for edge in edges {
            graph[edge[0], default: []].append(edge[1])
            inbound[edge[1]] += 1
        }
        
        var array: [Int] = [Int]()
        for index in 0..<inbound.count {
            if inbound[index] == 0 {
                array.append(index)
            }
        }
        
        var colors = Array(colors)
        var dict = [Int: [Character: Int]]()
        var result = -1
        while !array.isEmpty {
            let last = array.removeLast()
            var temp = dict[last, default: [:]]
            temp[colors[last], default: 0] += 1
            result = max(result, temp[colors[last], default: 0])
            
            for i in graph[last, default: []] {
                inbound[i] -= 1
                var tempDict = dict[i, default: [:]]
                for (key, value) in temp {
                    tempDict[key, default: 0] = max(tempDict[key, default: 0], value)
                }
                
                dict[i] = tempDict
                if inbound[i] == 0 {
                    array.append(i)
                }
            }
        }
        
        return inbound.filter { $0 > 0 }.count > 0 ? -1 : result
    }
}