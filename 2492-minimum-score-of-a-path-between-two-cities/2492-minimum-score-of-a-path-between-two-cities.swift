class Solution {
    /**
     Problem Summary:
     Find the minimum edge weight among all roads that belong to the connected component containing city 1.

     Strategy:
     Build an undirected adjacency list, then run BFS from city 1.
     Since any city connected to city 1 can be part of a valid path, the answer is the smallest road weight
     seen while traversing this connected component.

     Time Complexity:
     O(n + roads.count), because each city and road is processed at most once.

     Space Complexity:
     O(n + roads.count), for the adjacency list, queue, and visited set.
     */
    func minScore(_ n: Int, _ roads: [[Int]]) -> Int {
        var minimumRoadWeight = Int.max
        var adjacencyList = Array(repeating: [Path](), count: n + 1)

        // Build an undirected graph where each road connects two cities with a given weight.
        for road in roads {
            let sourceCity = road[0]
            let destinationCity = road[1]
            let roadWeight = road[2]

            adjacencyList[sourceCity].append(Path(destinationCity: destinationCity, weight: roadWeight))
            adjacencyList[destinationCity].append(Path(destinationCity: sourceCity, weight: roadWeight))
        }

        var queue = [1]
        var visitedCities: Set<Int> = [1]
        var queueIndex = 0

        // BFS from city 1 to visit every city in the same connected component.
        while queueIndex < queue.count {
            let currentCity = queue[queueIndex]
            queueIndex += 1

            for path in adjacencyList[currentCity] {
                // Any road inside this connected component can determine the minimum score.
                minimumRoadWeight = min(minimumRoadWeight, path.weight)

                // Visit each connected city only once.
                if !visitedCities.contains(path.destinationCity) {
                    visitedCities.insert(path.destinationCity)
                    queue.append(path.destinationCity)
                }
            }
        }

        return minimumRoadWeight
    }
}

extension Solution {
    struct Path {
        let destinationCity: Int
        let weight: Int
    }
}