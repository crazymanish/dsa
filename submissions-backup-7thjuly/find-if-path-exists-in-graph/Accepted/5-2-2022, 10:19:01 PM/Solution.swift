// https://leetcode.com/problems/find-if-path-exists-in-graph

class Solution {
    func validPath(_ n: Int, _ edges: [[Int]], _ source: Int, _ destination: Int) -> Bool {
        func buildGraphAdjacencyList(_ edges: [[Int]]) -> [Int : [Int]] {
            var adjacencyList: [Int : [Int]] = [:]
            
            for edge in edges {
                let sourceNode = edge[0]
                let destinationNode = edge[1]
                
                if adjacencyList[sourceNode] == nil { adjacencyList[sourceNode] = [] }
                if adjacencyList[destinationNode] == nil { adjacencyList[destinationNode] = [] }
                
                adjacencyList[sourceNode]! += [destinationNode]
                adjacencyList[destinationNode]! += [sourceNode]
            }
            
            return adjacencyList
        }
        
        func hasValidPathFromSourceNode(_ currentNode: Int) -> Bool {
            if visitedNodes.contains(currentNode) { return false }
            visitedNodes.insert(currentNode)
            
            if currentNode == destination { return true }
            
            let neighbors = graphAdjacencyList[currentNode] ?? []
            for neighbor in neighbors {
                let hashPath = hasValidPathFromSourceNode(neighbor)
                if hashPath == true { return true }
            }
            
            return false
        }
        
        var visitedNodes: Set<Int> = []
        let graphAdjacencyList = buildGraphAdjacencyList(edges)
        
        return hasValidPathFromSourceNode(source)
    }
}