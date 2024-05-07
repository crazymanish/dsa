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
    func doubleIt(_ head: ListNode?) -> ListNode? {
      // Step 1: Traverse the linked list and push nodes onto a stack
        var stack: [ListNode] = []
        var curr = head
        
        // Traverse the original linked list and push each node onto the stack
        while let node = curr {
            stack.append(node)
            curr = node.next
        }

        // Step 2: Process nodes in reverse order to double values and handle carry
        var carry = 0
        while !stack.isEmpty {
            // Pop the last node from the stack (reverse order traversal)
            let node = stack.removeLast()
            
            // Calculate new value for the current node: double the value + carry
            let newValue = node.val * 2 + carry
            node.val = newValue % 10 // Update node value with the last digit of newValue
            carry = newValue / 10     // Update carry for the next iteration
        }

        // Step 3: Handle any remaining carry by creating a new node if needed
        if carry > 0 {
            // Create a new node with the carry value
            let newNode = ListNode(carry)
            // Link the new node to the original head (or modified head)
            newNode.next = head
            // Return the new node as the new head of the linked list
            return newNode
        }

        // Return the (potentially modified) head of the linked list
        return head
    }
}