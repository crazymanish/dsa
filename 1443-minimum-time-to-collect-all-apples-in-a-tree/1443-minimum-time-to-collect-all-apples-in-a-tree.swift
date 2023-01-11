class Solution {
    func minTime(_ n: Int, _ edges: [[Int]], _ hasApple: [Bool]) -> Int {
        guard hasApple.contains(true) else { return 0 }
        
        //Create an array with a slot for each vertex in the tree
        var adjacencyList = [[Int]](repeating: [], count: n)
        var time = 0
        
        //For each edge create a bidirectional edge between the two vertices
        for edge in edges {
            let currentNode = edge[0]
            let neighbor = edge[1]
            
            adjacencyList[currentNode].append(neighbor)
            adjacencyList[neighbor].append(currentNode)
        }
        
        //Now we need to traverses the tree
        func dfs(_ currentNode: Int, _ parentNode: Int) -> Bool {
            var isApple = hasApple[currentNode]
            
            //Iterate through all the neighbors of the current vertex
            for neighbor in adjacencyList[currentNode] {
                
                //Check whether the current neighbor is not the parent of the current vertex
                //We don't want to visit the parent node again since it's already visited
                //Current vertex is the last vertex to be visited in the path of the parent
                if neighbor != parentNode {
                    if dfs(neighbor, currentNode) {
                        isApple = true
                        
                        //If the current node or its neighbor has an apple,
                        //it means that we need to spend 2 seconds to go to that vertex
                        time += 2
                    }
                }
            }
            
            return isApple
        }
        
        //call the function to start tree traversal
        dfs(0, -1)
        
        return time
    }
}