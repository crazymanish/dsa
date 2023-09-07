/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */
class Solution {
    func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        if left == right { return head }
        
        var count = 1
        
        // use dummy node, we will return dummy.next as the answer
        let dummy = ListNode(0, head)
        
        // Use previousNode and currentNode to maintain the linked list
        var previousNode: ListNode? = dummy
        var currentNode: ListNode? = head
        
        // Find the left and right node and keep them
        // After finish the while loop, `previousNode` will be the left node and `currentNode` will be the right node
        // For example 1 -> 2 -> 3 -> 4 -> 5 , left = 2, right = 4
        // After reversing the linked list will be 1 -> 4 -> 3 -> 2 -> 5. 
        // In this case `1` will be the left node and `2` will be the right node
        while currentNode != nil, count < left {
            previousNode = currentNode
            currentNode = currentNode?.next
            count += 1
        }
        
        var leftNode = previousNode
        var rightNode = currentNode
        
        previousNode = currentNode
        currentNode = currentNode?.next
        count += 1
        
        // reverse
        while currentNode != nil, count <= right {
            let tempNode = currentNode?.next
            currentNode?.next = previousNode
            previousNode = currentNode
            currentNode = tempNode
            count += 1
        }
        
        // connect the left node and the right node
        leftNode?.next = previousNode
        rightNode?.next = currentNode
        
        return dummy.next
    }
}