class TreeNode {
    var token: Character?
    var children = [TreeNode]()
    var parent: TreeNode?
}

class Solution {
    func parseBoolExpr(_ expression: String) -> Bool { 
        // Build parse tree based on "expression".
        func buildTree(for expression: String) -> TreeNode {
            var node = TreeNode()
            for token in expression {
                switch token {
                case "!", "&", "|", "t", "f":
                    node.token = token
                case "(":
                    // Add a first child to "node" and move to that child.
                    let child = TreeNode()
                    child.parent = node
                    node.children = [child]
                    node = child
                case ",": 
                    // Add a sibling to "node" and move to sibling.
                    let sibling = TreeNode()
                    sibling.parent = node.parent
                    node.parent?.children.append(sibling)
                    node = sibling
                case ")":
                    // Move back to parent.
                    node = node.parent!
                default: fatalError("unknown token")
                }
            }
            return node
        }

        // Evaluate parse tree recursively.
        func evalTree(_ treeNode: TreeNode) -> Bool {
            switch treeNode.token {
            case "t": true
            case "f": false
            case "!": !evalTree(treeNode.children[0])
            case "&": treeNode.children.map(evalTree).allSatisfy { $0 }
            case "|": !treeNode.children.map(evalTree).allSatisfy { !$0 }
            default: fatalError("unknown token")
            }
        }
        
        let treeNode = buildTree(for: expression)
        return evalTree(treeNode)
    }
}