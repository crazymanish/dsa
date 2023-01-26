class Solution {
    func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ K: Int) -> Int {
        var graph: [Int: [(Int, Int)]] = [:] // [src: (dst, price)]
        var weights: [Int: Int] = [:] // [city: price]
        var queue:[(Int, Int, Int)] = [] // (src, runningPrice, runningK)
        
        // Building Graph [src: (dst, price)]
        for flight in flights {
            graph[flight[0], default: []].append((flight[1], flight[2]))
        }
        
        // Build Queue (src, runningPrice, runningK)
        queue.append((src, 0, 0))
        
        // Go BFS Approach 
        while !queue.isEmpty {
            let node = queue.removeFirst()
            let src = node.0
            let runningPrice = node.1
            let runningK = node.2
            
            // Check for Stops So far
            if runningK == K + 1 { 
                //Deplete the queue destination node has been traveresed 
                continue
            }
            
            // Traverse the graph
            for edge in graph[src] ?? [] {
                let dstCity = edge.0
                let dstCityPrice = edge.1
                let newRunningPrice = runningPrice + dstCityPrice
                
                while weights[dstCity] == nil || weights[dstCity]! > newRunningPrice {
                    weights[dstCity] = newRunningPrice
                    queue.append((dstCity, newRunningPrice, runningK + 1))
                }
            }
              
        }
        
        return weights[dst] ?? -1
    }
}


/* Time limit exceeded
class Solution {
    /// We will be using BFS to solve this question.
    /// Create a graph where the key is the departure city and the value is the arrival city and the flight price.
    /// Create a queue that contains an object which keeps track of the current city, number of stops and the total running price.
    /// Populate the queue with the first city and the number of stops (0) with the total running price (0).
    /// For each element in the queue we will travel to each neighboring city and keep track of the number of stops and running price.
    /// Stop exploring if the current city is the destination city or the total running price is greater than the minimum price or the number of stops is greater than K.
    func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ k: Int) -> Int {
	    var graph = [Int: [(Int, Int)]]()
	    for flight in flights {
		    graph[flight[0], default: []].append((flight[1], flight[2]))
	    }

        typealias element = (city: Int, stops: Int, runningPrice: Int)
	    var queue = [element]()
	    queue.append((city: src, stops: 0, runningPrice: 0))

	    var cheapestPrice = Int.max

	    while !queue.isEmpty {
		    let (city, stops, runningPrice) = queue.removeFirst()

		    if city == dst {
			    cheapestPrice = min(cheapestPrice, runningPrice)
			    continue
		    }

		    if stops > k || runningPrice > cheapestPrice { continue }

		    for (nextCity, flightPrice) in graph[city] ?? [] {
			    queue.append((nextCity, stops + 1, runningPrice + flightPrice))
		    }
	    }

	    return cheapestPrice != Int.max ? cheapestPrice : -1
    }
}
*/