class Solution {
    func checkIfPrerequisite(_ numCourses: Int, _ prerequisites: [[Int]], _ queries: [[Int]]) -> [Bool] {
        // Initialize the adjacency matrix for the Floyd-Warshall algorithm
        var isPrerequisite = Array(repeating: Array(repeating: false, count: numCourses), count: numCourses)
        
        // Fill the adjacency matrix with the given prerequisites
        for prerequisite in prerequisites {
            let u = prerequisite[0]
            let v = prerequisite[1]
            isPrerequisite[u][v] = true
        }
        
        // Floyd-Warshall algorithm to find the transitive closure
        for k in 0..<numCourses {
            for i in 0..<numCourses {
                for j in 0..<numCourses {
                    if isPrerequisite[i][k] && isPrerequisite[k][j] {
                        isPrerequisite[i][j] = true
                    }
                }
            }
        }
        
        // Answer the queries based on the transitive closure
        var result = [Bool]()
        for query in queries {
            let u = query[0]
            let v = query[1]
            result.append(isPrerequisite[u][v])
        }
        
        return result
    }
}