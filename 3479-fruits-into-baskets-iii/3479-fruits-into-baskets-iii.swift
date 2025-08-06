// Time Complexity: O(B + F * log B)
//   - B: Number of baskets
//   - F: Number of fruits
//   - Building the Segment Tree takes O(B) time.
//   - For each of the F fruits, we perform a search and an update on the Segment Tree.
//   - Both searching (`findLeftmost`) and updating take O(log B) time.
// Space Complexity: O(B)
//   - The Segment Tree requires an underlying array of size approximately 4 * B.
class Solution {
  /**
   * Calculates the number of fruits that cannot be placed in any available basket.
   *
   * - Parameters:
   * - fruits: An array of integers representing the size of each fruit.
   * - baskets: An array of integers representing the capacity of each basket.
   * - Returns: The count of fruits that could not be placed.
   */
  func numOfUnplacedFruits(_ fruits: [Int], _ baskets: [Int]) -> Int {
    // `count(where:)` iterates through `fruits` and counts elements satisfying the closure.
    // The capture list `[tree=SegmentTree(baskets)]` efficiently creates the Segment Tree once
    // before the iteration begins. This avoids rebuilding the tree for every fruit.
    // For each fruit `f`, we try to place it by calling `removeLeftmost(f)`.
    // `removeLeftmost` returns `true` on a successful placement and `false` otherwise.
    // The `!` negates the result, so we count the fruit only when placement fails.
    fruits.count { [tree = SegmentTree(baskets)] f in
      !tree.removeLeftmost(f)
    }
  }
}

/**
 * A Segment Tree data structure optimized for this problem.
 * It stores the maximum capacity within any given range of baskets.
 * This allows for efficient querying to find a suitable basket and updating its capacity once used.
 */
class SegmentTree {
    /// The array that stores the segment tree nodes. Each node holds the max value of its range.
    var tree: [Int]
    /// The number of elements in the original array (number of baskets).
    var n: Int
    
    /**
     * Initializes the Segment Tree from an array of basket capacities.
     *
     * - Parameter arr: The initial array of basket capacities.
     */
    init(_ arr: [Int]) {
        self.n = arr.count
        // Allocate 4*n space for the tree, a safe upper bound for a binary tree structure.
        self.tree = Array(repeating: 0, count: 4 * n)
        // Build the tree recursively starting from the root (node 1).
        build(arr, 1, 0, n - 1)
    }
    
    /**
     * Recursively builds the segment tree.
     *
     * - Parameters:
     * - arr: The original array of values.
     * - node: The index of the current node in the `tree` array.
     * - start: The starting index of the segment represented by this node.
     * - end: The ending index of the segment represented by this node.
     */
    func build(_ arr: [Int], _ node: Int, _ start: Int, _ end: Int) {
        if start == end {
            // Leaf node: store the actual value from the input array.
            tree[node] = arr[start]
        } else {
            // Internal node: recursively build left and right children.
            let mid = (start + end) / 2
            build(arr, 2 * node, start, mid) // Build left child
            build(arr, 2 * node + 1, mid + 1, end) // Build right child
            // Store the maximum value of the children in the current node.
            tree[node] = max(tree[2 * node], tree[2 * node + 1])
        }
    }
    
    /**
     * Finds the leftmost basket that can hold a fruit of size `val`,
     * and if found, sets its capacity to 0 to mark it as used.
     *
     * - Parameter val: The size of the fruit to place.
     * - Returns: `true` if a basket was found and updated, `false` otherwise.
     */
    func removeLeftmost(_ val: Int) -> Bool {
        // Find the index of the leftmost basket with capacity >= val.
        guard let idx = findLeftmost(val) else {
            // If no suitable basket is found, return false.
            return false
        }
        
        // A nested function to perform the update recursively.
        func update(_ node: Int, _ start: Int, _ end: Int) {
            if start == end {
                // We've reached the leaf node corresponding to the basket's index.
                // Set its capacity to 0 to indicate it's now used.
                tree[node] = 0
            } else {
                let mid = (start + end) / 2
                // Recurse down to the correct child.
                if idx <= mid {
                    update(2 * node, start, mid)
                } else {
                    update(2 * node + 1, mid + 1, end)
                }
                // After updating a child, re-calculate the max for the current node.
                tree[node] = max(tree[2 * node], tree[2 * node + 1])
            }
        }
        
        // Start the update process from the root of the tree.
        update(1, 0, n - 1)
        return true
    }
    
    /**
     * Finds the index of the leftmost element in the original array
     * that has a value greater than or equal to `minVal`.
     *
     * - Parameter minVal: The minimum capacity required for the basket.
     * - Returns: An optional integer with the index if found, otherwise `nil`.
     */
    func findLeftmost(_ minVal: Int) -> Int? {
        // A nested function to perform the search recursively.
        func search(_ node: Int, _ start: Int, _ end: Int) -> Int? {
            // Pruning: If the max capacity in this entire segment is less than
            // the required value, there's no suitable basket in this branch.
            guard tree[node] >= minVal else { return nil }
            
            // Base case: If we are at a leaf node and it passed the guard, this is a valid candidate.
            guard start < end else { return start }
            
            let mid = (start + end) / 2
            
            // Search the left subtree first. The nil-coalescing operator `??` ensures
            // that we only search the right subtree if the left one returns no result.
            // This guarantees we find the *leftmost* match.
            return search(2 * node, start, mid) ?? search(2 * node + 1, mid + 1, end)
        }
        
        // Start the search from the root of the tree.
        return search(1, 0, n - 1)
    }
}