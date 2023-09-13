class Solution {
    func candy(_ ratings: [Int]) -> Int {
        var candies = Array(repeating: 1, count: ratings.count)
    
        let rightNeighbors = ratings.indices.dropLast().map { (greater: $0, lesser: $0+1) }
        let leftNeighbors = ratings.indices.dropFirst().map { (greater: $0, lesser: $0-1) }
        let checks = (leftNeighbors+rightNeighbors).filter { ratings[$0.greater] > ratings[$0.lesser] }
        let sortedChecks = checks.sorted { ratings[$0.greater] < ratings[$1.greater] }
    
        for (greater, lesser) in sortedChecks {
            candies[greater] = max(candies[greater], candies[lesser]+1)
        }
    
        return candies.reduce(0, +)
    }
}