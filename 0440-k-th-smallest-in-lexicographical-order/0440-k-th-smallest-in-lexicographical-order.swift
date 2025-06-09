class Solution {
    /// Finds the k-th smallest number in lexicographical order from 1 to n.
    ///
    /// The algorithm simulates a traversal on a 10-ary prefix tree.
    ///
    /// ## Time Complexity: O((log₁₀n)²)
    /// The path from the root of the prefix tree to any node is at most O(log n) long.
    /// At each step of the traversal, we call `calculateNodesInGap`, which also runs
    /// in O(log n) time because it iterates through the levels of the tree.
    /// This results in a total time complexity of O(log n * log n).
    ///
    /// ## Space Complexity: O(1)
    /// The solution uses a fixed number of variables to keep track of the state,
    /// so the space required is constant and does not depend on the input size `n` or `k`.

    func findKthNumber(_ n: Int, _ k: Int) -> Int {
        var currentNode = 1
        // We need to take k-1 steps from the first number (1) to reach the k-th number.
        var stepsRemaining = k - 1

        while stepsRemaining > 0 {
            // Calculate the number of nodes between the current node and its next sibling.
            let nodesInGap = calculateNodesInGap(n1: currentNode, n2: currentNode + 1, limit: n)

            if nodesInGap <= stepsRemaining {
                // The target is not in the current subtree.
                // Skip over all nodes in this gap and move to the next sibling.
                stepsRemaining -= nodesInGap
                currentNode += 1
            } else {
                // The target is in the current subtree.
                // Move down to the first child. This counts as one step.
                stepsRemaining -= 1
                currentNode *= 10
            }
        }
        return currentNode
    }

    /// Calculates the number of lexicographical nodes between two prefixes, n1 and n2,
    /// up to a given limit.
    ///
    /// For example, with limit=100, calculateNodesInGap(n1: 1, n2: 2) would count
    /// 1, 10, 11, ..., 19, 100.
    private func calculateNodesInGap(n1: Int, n2: Int, limit: Int) -> Int {
        var count = 0
        var levelStart = n1
        var nextLevelStart = n2

        // Iterate through each level of the prefix tree.
        while levelStart <= limit {
            // Add the number of nodes in the current level's range.
            // The range is [levelStart, nextLevelStart), but capped by the limit.
            count += min(limit + 1, nextLevelStart) - levelStart
            
            // Move to the next level down.
            levelStart *= 10
            nextLevelStart *= 10
        }
        return count
    }
}