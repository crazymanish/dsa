/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */
class Solution {
    // Function to calculate the minimum number of swaps required to sort an array
    func minSwaps(_ arr: [Int]) -> Int {
        var arr = arr
        let n = arr.count
        var ans = 0
        
        // Create a temporary array of tuples (value, original index) and sort it by value
        var temp = arr.enumerated().sorted { $0.element < $1.element }
        
        // Create a visited array to keep track of visited elements
        var visited = [Bool](repeating: false, count: n)
        
        // Iterate through the array to find cycles
        for i in 0..<n {
            // If the element is already visited or is in the correct position, skip it
            if visited[i] || temp[i].offset == i {
                continue
            }
            
            // Calculate the size of the cycle
            var cycleSize = 0
            var j = i
            
            // Traverse the cycle and mark elements as visited
            while !visited[j] {
                visited[j] = true
                j = temp[j].offset
                cycleSize += 1
            }
            
            // If the cycle size is greater than 0, add (cycleSize - 1) to the answer
            if cycleSize > 0 {
                ans += (cycleSize - 1)
            }
        }
        
        return ans
    }
    
    // Function to calculate the minimum number of operations required to sort the binary tree level by level
    func minimumOperations(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        
        var queue = [TreeNode]()
        queue.append(root)
        var totalOperations = 0
        
        // Perform level order traversal (BFS)
        while !queue.isEmpty {
            let levelSize = queue.count
            var levelValues = [Int]()
            
            // Collect node values for the current level
            for _ in 0..<levelSize {
                let node = queue.removeFirst()
                levelValues.append(node.val)
                
                // Add left and right children to the queue
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            
            // Calculate the minimum number of swaps needed to sort the current level
            totalOperations += minSwaps(levelValues)
        }
        
        return totalOperations
    }
}