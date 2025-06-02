// Time Complexity: O(N log N), where N is the number of ratings.
//   - Initialization of `candies` array: O(N).
//   - Creating `rightNeighbors` and `leftNeighbors` pairs: O(N) time, as it iterates through indices.
//   - Concatenating `allPotentialChecks`: O(N).
//   - Filtering to create `checks`: O(N), as it iterates through O(N) pairs. `checks` can have up to 2*(N-1) elements.
//   - Sorting `checks` to create `sortedChecks`: O(M log M), where M is the number of elements in `checks`. Since M is O(N), this is O(N log N).
//   - Final loop over `sortedChecks`: O(N) in the worst case (if M is O(N)).
//   - Summing candies using `reduce`: O(N).
//   - Overall: The sort operation O(N log N) dominates the time complexity.
//
// Space Complexity: O(N)
//   - `candies` array: O(N).
//   - `rightNeighbors`, `leftNeighbors`, `allPotentialChecks`, `checks`, `sortedChecks`: Each of these arrays/collections can store O(N) elements (tuples) in the worst case.
//   - Overall: O(N) for storing these intermediate collections and the `candies` array.

class Solution {
    func candy(_ ratings: [Int]) -> Int {
        let numChildren = ratings.count
        if numChildren == 0 {
            return 0
        }
        
        // Rule 1: Each child must have at least one candy.
        // Initialize an array to store the number of candies for each child, starting with 1 for everyone.
        var candies = Array(repeating: 1, count: numChildren)
    
        // Create pairs of indices: (current_child_idx, neighbor_idx).
        // In the .map closure, tuple element `greater` is assigned $0 (the current child's index),
        // and `lesser` is assigned the neighbor's index.
        // At this stage, `greater` and `lesser` are just labels for the first and second elements of the tuple;
        // they don't yet imply a rating comparison.
        let rightNeighbors = ratings.indices.dropLast().map { (greater: $0, lesser: $0 + 1) }
        let leftNeighbors = ratings.indices.dropFirst().map { (greater: $0, lesser: $0 - 1) }
        
        // Combine all pairs representing a child and an adjacent neighbor.
        let allPotentialChecks = leftNeighbors + rightNeighbors
        
        // Filter these pairs to get the actual "checks" or tasks that require candy adjustment.
        // A check `(idx_A, idx_B)` is kept if `ratings[idx_A] > ratings[idx_B]`.
        // After this filter, for each tuple `t` in the resulting `checks` array:
        //   - `t.greater` IS the index of the child with the strictly higher rating in that pair.
        //   - `t.lesser` IS the index of the child with the strictly lower rating in that pair.
        // The tuple element names `greater` and `lesser` now accurately reflect the rating relationship for the elements within `checks`.
        let checks = allPotentialChecks.filter { pairCandidate in
            // `pairCandidate.greater` refers to the first element of the tuple (the $0 from map).
            // `pairCandidate.lesser` refers to the second element of the tuple (the neighbor index).
            ratings[pairCandidate.greater] > ratings[pairCandidate.lesser]
        }

        // Sort these checks.
        // The sorting key is the rating of the child at index `check.greater` (the higher-rated child in the pair).
        // Checks involving children whose "greater" rating is lower are processed first. This order helps
        // propagate candy requirements correctly.
        let sortedChecks = checks.sorted { check1, check2 in
            ratings[check1.greater] < ratings[check2.greater]
        }
    
        // Rule 2: Children with a higher rating get more candies than their adjacent lower-rated neighbors.
        // Iterate through the sorted checks and apply candy adjustments.
        // For each check (a tuple `(greater, lesser)` from `sortedChecks`), `greater` is the index
        // of the higher-rated child and `lesser` is the index of the adjacent, lower-rated child.
        for (greater, lesser) in sortedChecks { // Deconstructing the tuple directly
            // The child with the higher rating (`greater`) must have more candies
            // than the child with the lower rating (`lesser`).
            // It should be at least `candies[lesser] + 1`.
            // We also need to respect any candies `candies[greater]` might have received
            // from other comparisons, so we take the maximum.
            candies[greater] = max(
                candies[greater],          // Current candies for the higher-rated child
                candies[lesser] + 1        // Minimum candies required based on the lower-rated neighbor
            )
        }
    
        // Calculate the total number of candies required by summing up the candies for each child.
        return candies.reduce(0, +)
    }
}
