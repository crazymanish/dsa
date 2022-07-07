// https://leetcode.com/problems/all-paths-from-source-to-target

class Solution {
    func allPathsSourceTarget(_ graph: [[Int]]) -> [[Int]] {
        let sourceNode = 0
        let destinationNode = graph.count-1
        
        var allPaths: [[Int]] = []
        var currentPath: [Int] = []
        
        func findAllPathsUsingDFS(_ currentNode: Int) {
            currentPath += [currentNode]
            
            if currentNode == destinationNode {
                allPaths.append(currentPath)
            }
            
            for nextNode in graph[currentNode] {
                findAllPathsUsingDFS(nextNode)
                
                // backtracking, removing the last item for next recursion call
                currentPath.removeLast() 
            }
        }
        
        findAllPathsUsingDFS(sourceNode)
        return allPaths
    }
}