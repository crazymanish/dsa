class Solution {
    func secondMinimum(_ n: Int, _ edges: [[Int]], _ time: Int, _ change: Int) -> Int {
        // Initialize the adjacency list for the graph
        var graph = [Int: [Int]]()
        for edge in edges {
            let u = edge[0]
            let v = edge[1]
            graph[u, default: []].append(v)
            graph[v, default: []].append(u)
        }
        
        // Use a queue to perform BFS, keeping track of node, time, and number of visits
        var queue = [(node: 1, time: 0)]
        // Array to track visits to nodes, initialized to 0
        var visited = Array(repeating: 0, count: n + 1)
        // Mark the starting node (node 1) as visited once
        visited[1] = 1
        
        // Arrays to store the shortest and second shortest times to each node
        var firstTimes = Array(repeating: Int.max, count: n + 1)
        var secondTimes = Array(repeating: Int.max, count: n + 1)
        // The shortest time to reach node 1 is 0
        firstTimes[1] = 0
        
        // Perform BFS
        while !queue.isEmpty {
            // Dequeue the first element (current node and time)
            let (currentNode, currentTime) = queue.removeFirst()
            
            // Traverse all neighbors of the current node
            for neighbor in graph[currentNode, default: []] {
                // Calculate the new time to reach this neighbor
                var newTime = currentTime + time
                // If the current time falls within a red signal period
                if (currentTime / change) % 2 == 1 {
                    // Add the waiting time until the next green signal
                    newTime += change - (currentTime % change)
                }
                
                // If the new time is less than the currently known shortest time to the neighbor
                if newTime < firstTimes[neighbor] {
                    // Update the second shortest time to the neighbor
                    secondTimes[neighbor] = firstTimes[neighbor]
                    // Update the shortest time to the neighbor
                    firstTimes[neighbor] = newTime
                    // Enqueue this neighbor with the new time
                    queue.append((neighbor, newTime))
                } else if newTime > firstTimes[neighbor] && newTime < secondTimes[neighbor] {
                    // If the new time is between the shortest and second shortest times
                    // Update the second shortest time to the neighbor
                    secondTimes[neighbor] = newTime
                    // Enqueue this neighbor with the new time
                    queue.append((neighbor, newTime))
                }
            }
        }
        
        // Return the second shortest time to reach node n
        return secondTimes[n]
    }
}