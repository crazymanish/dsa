/**
 * Definition for a Node.
 * public class Node {
 *     public var val: Int
 *     public var next: Node?
 *     public var random: Node?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *    	   self.random = nil
 *     }
 * }
 */

class Solution {
	// store orig node next to new node
    var hashMap: [Node: Node] = [:]
	
    func copyRandomList(_ head: Node?) -> Node? {
        let newHead = copyNextNodes(head)
        copyRandomNodes(head)
        return newHead
    }
    
	// copy the body of the list using .next
    func copyNextNodes(_ head: Node?) -> Node? {
        guard let head = head else { return nil }
        
        let newHead = Node(head.val)
        hashMap[head] = newHead
        newHead.next = copyNextNodes(head.next)
        
        return newHead
    }
	
	// copy the random links using the hashMap
    func copyRandomNodes(_ head: Node?) {
        guard let head = head else { return }
        
        if let random = head.random {
            hashMap[head]?.random = hashMap[random]
        }
        
        copyRandomNodes(head.next)
    }
}