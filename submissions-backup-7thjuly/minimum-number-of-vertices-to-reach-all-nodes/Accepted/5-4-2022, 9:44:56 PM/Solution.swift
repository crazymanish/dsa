// https://leetcode.com/problems/minimum-number-of-vertices-to-reach-all-nodes

class Solution {
    func findSmallestSetOfVertices(_ n: Int, _ edges: [[Int]]) -> [Int] {
        //Idea: We only have to count the number of nodes with zero incoming edges.
        
        var sourceNodes: Set<Int> = Set(0..<n)
        
        for edge in edges {
            let destinationNode = edge[1]
            
            if sourceNodes.contains(destinationNode) {
                sourceNodes.remove(destinationNode)
            }
        }
        
        return Array(sourceNodes)
    }
}

/*
class Solution {
    func findSmallestSetOfVertices(_ n: Int, _ edges: [[Int]]) -> [Int] {
        //Idea: We only have to count the number of nodes with zero incoming edges.
        
        var sourceNodes: Set<Int> = []
        var destinationNodes: Set<Int> = []
        
        for edge in edges {
            let sourceNode = edge[0]
            let destinationNode = edge[1]
            
            destinationNodes.insert(destinationNode)
            
            if sourceNodes.contains(destinationNode) {
                sourceNodes.remove(destinationNode)
            }
            
            if destinationNodes.contains(sourceNode) == false {
                sourceNodes.insert(sourceNode)
            }
        }
        
        return Array(sourceNodes)
    }
}
*/