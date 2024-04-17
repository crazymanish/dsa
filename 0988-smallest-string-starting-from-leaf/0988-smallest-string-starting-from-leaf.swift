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
    func smallestFromLeaf(_ root: TreeNode?) -> String {
	    guard let root else { return "" }

	    let alpahabets = (97...122).map({String(Character(UnicodeScalar($0)))})
	    var queue = [(node: root, str: "")]
        var result = "|"

	    while !queue.isEmpty {
		    for _ in queue {
			    let obj = queue.removeFirst()
			    let str = alpahabets[obj.node.val] + obj.str

			    // if current node is leaf, check string
			    if obj.node.left == nil, obj.node.right == nil, str < result {
				    result = str
			    }

			    if let left = obj.node.left { queue.append((node: left, str: str)) }
			    if let right = obj.node.right { queue.append((node: right, str: str)) }
		    }
	    }

	    return result
    }
}