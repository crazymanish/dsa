/**
 * Definition for a QuadTree node.
 * public class Node {
 *     public var val: Bool
 *     public var isLeaf: Bool
 *     public var topLeft: Node?
 *     public var topRight: Node?
 *     public var bottomLeft: Node?
 *     public var bottomRight: Node?
 *     public init(_ val: Bool, _ isLeaf: Bool) {
 *         self.val = val
 *         self.isLeaf = isLeaf
 *         self.topLeft = nil
 *         self.topRight = nil
 *         self.bottomLeft = nil
 *         self.bottomRight = nil
 *     }
 * }
 */

class Solution {
    func construct(_ grid: [[Int]]) -> Node? {
        func isSame(_ x: Int, _ y: Int, _ length: Int) -> Bool {
            for i in x..<(x+length) {
                for j in y..<(y+length) {
                    if grid[i][j] != grid[x][y] {
                        return false
                    }
                }
            }
            return true
        }

        func solveGrid(_ x: Int, _ y: Int, _ length: Int) -> Node? {
            if isSame(x, y, length) {
                return Node(grid[x][y] == 1, true)
            } else {
                let root = Node(false, false)
                let halfLength = length/2
                
                root.topLeft = solveGrid(x, y, halfLength)
                root.topRight = solveGrid(x, y+halfLength, halfLength)
                root.bottomLeft = solveGrid(x+halfLength, y, halfLength)
                root.bottomRight = solveGrid(x+halfLength, y+halfLength, halfLength)
                return root
            }
        }

        return solveGrid(0, 0, grid.count)
    }
}