class Solution {
    enum NodeState: Int {
        case unknown = 0
        case unsafe = 1
        case safe = 2
    }
    
    func eventualSafeNodes(_ graph: [[Int]]) -> [Int] {
        let size = graph.count
        var colour = Array<NodeState>(repeating: .unknown, count: size)
        
        
        func traverse(index: Int) -> Bool {
            if colour[index] != .unknown {
                return colour[index] == .safe
            }
        
            colour[index] = .unsafe
        
            for i in 0..<graph[index].count {
                if colour[graph[index][i]]  == .unsafe || traverse(index: graph[index][i]) == false {
                    return false
                }
            }
            
            colour[index] = .safe
            return true
        }
        
        var result = [Int]()
        for i in 0..<size {
            if traverse(index: i) {
                result.append(i)
            }
        }
        
        return result
    }
}