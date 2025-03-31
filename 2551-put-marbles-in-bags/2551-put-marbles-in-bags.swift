class Solution {
    func putMarbles(_ weights: [Int], _ k: Int) -> Int {
        let numberOfWeights = weights.count

        // If k is 1 or equal to the number of weights, the difference is 0.
        if k == 1 || k == numberOfWeights { return 0 }

        // Calculate the sums of adjacent weights. These sums represent the cost of splitting at that point.
        let adjacentWeightSums: [Int] = (1..<numberOfWeights).map { index in
            weights[index - 1] + weights[index]
        }

        // If k is 2 or n-1, the result is the difference between the max and min adjacent sums
        if k == 2 || k == numberOfWeights - 1 {
            return adjacentWeightSums.max()! - adjacentWeightSums.min()!
        }

        // Sort the adjacent weight sums to easily find the smallest and largest k-1 sums.
        let sortedAdjacentWeightSums = adjacentWeightSums.sorted()

        // Calculate the minimum score by summing the smallest k-1 adjacent sums and the weights of the first and last marbles.
        var minScore = weights.first! + weights.last!
        for i in 0..<(k - 1) {
            minScore += sortedAdjacentWeightSums[i]
        }

        // Calculate the maximum score by summing the largest k-1 adjacent sums and the weights of the first and last marbles.
        var maxScore = weights.first! + weights.last!
        for i in (numberOfWeights - k)..<(numberOfWeights - 1) {
            maxScore += sortedAdjacentWeightSums[i]
        }

        // Return the difference between the maximum and minimum scores.
        return maxScore - minScore
    }
}