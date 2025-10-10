// Time Complexity: O(N)
// where N is the number of elements in the `energy` array.
// The `calculate` function uses memoization (caching), ensuring that the energy sum
// for each index is computed only once. The main loop iterates N times, but
// calls to `calculate` for an already computed path or subpath return in O(1) time.
// Thus, every index's energy sum is fully calculated exactly once.
//
// Space Complexity: O(N)
// The `cache` dictionary can store up to N entries. The recursion depth can also
// go up to N in the worst case (when k=1), contributing to the space complexity.
final class Solution {
    // `cache` is used for memoization to store the results of subproblems.
    // It maps a starting index to the maximum energy that can be collected from that point.
    private var cache: [Int: Int] = [:]

    func maximumEnergy(_ energy: [Int], _ k: Int) -> Int {
        // `maximum` will store the highest energy sum found across all possible starting points.
        var maximum = Int.min
        
        // Iterate through every possible starting index in the energy array.
        // Although this loop runs N times, memoization ensures we don't recompute
        // overlapping subproblems, making the overall process efficient.
        for index in 0..<energy.count {
            maximum = max(maximum, calculate(index, energy, k))
        }
        
        return maximum
    }
    
    // `calculate` is a recursive helper that computes the total energy
    // for a path starting at `index`, with jumps of size `k`.
    private func calculate(_ index: Int, _ energy: [Int], _ k: Int) -> Int {
        // Base case: If the index goes out of bounds, the path ends, adding no more energy.
        guard index < energy.count else { return 0 }
        
        // Memoization check: If we have already calculated the energy from this index,
        // return the cached value immediately to avoid redundant work.
        if let cached = cache[index] { return cached }
        
        // Recursive step: The total energy from the current `index` is its own energy
        // plus the total energy gained from the rest of the path, which starts at `index + k`.
        let sum = energy[index] + calculate(index + k, energy, k)
        
        // Store the result in the cache before returning it.
        cache[index] = sum
        return sum
    }
}