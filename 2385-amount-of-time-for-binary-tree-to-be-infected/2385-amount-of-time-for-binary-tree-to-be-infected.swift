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
    func amountOfTime(_ root: TreeNode?, _ start: Int) -> Int {
        guard let root = root else { return .zero }
        
        var queue = [root]
        var graph = [Int: [Int]]()
        while let node = queue.popLast() {
            if let left = node.left {
                graph[node.val, default: []].append(left.val)
                graph[left.val, default: []].append(node.val)
                queue.append(left)
            }
            if let right = node.right {
                graph[node.val, default: []].append(right.val)
                graph[right.val, default: []].append(node.val)
                queue.append(right)
            }
        }
        
        var time = -1
        var gQueue = [start]
        var visited = Set(gQueue)
        
        while !gQueue.isEmpty {
            time += 1
            var newQueue = [Int]()
            for node in gQueue {
                visited.insert(node)
                for neigh in graph[node, default: []] where !visited.contains(neigh) {
                    newQueue.append(neigh)
                }
            }
            gQueue = newQueue
        }
        
        return time
    }
}