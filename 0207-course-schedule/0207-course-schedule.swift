class Solution {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        var graph = [Int: Set<Int>]()
        var visited = Set<Int>()
        
        // Build the graph
        for item in prerequisites {
            let course = item[0]
            let prerequisite = item[1]
            
            graph[course, default: []].insert(prerequisite)
        }
        
        func dfs(_ course: Int) -> Bool {
            // Check for loop 
            if visited.contains(course) { return false }
        
            // Does not have a prerequisite, i.e doesnt exist in the graph  
            guard let prerequisites = graph[course] else { return true }
       
            if prerequisites.isEmpty { return true }
        
            visited.insert(course)
            
            for nextCourse in prerequisites {
                if dfs(nextCourse) == false { return false }
            }
            
            graph[course] = []
            visited.remove(course)
            return true
        }

        // Loop through all courses 
        for course in graph.keys {
            if dfs(course) == false { return false }
        }
        
        return true
    }
}