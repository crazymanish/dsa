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
    func reorderList(_ head: ListNode?) {
        if head == nil { return }
        
        var node = head 
        let stack = Stack()
        stack.push(node!)
        
        while let next = node?.next {
            stack.push(next)
            node = next
        }

        node = head
        while let next = node?.next, let endNode = stack.pop() {

            node?.next = endNode
            endNode.next = next

            node = next

            if node?.next === endNode {
                node?.next = nil
                break
            }
        }
    }
}

class Stack {
    private var array: [ListNode] = []
    
    func push(_ element: ListNode) {
        array.append(element)
    }
    
    func pop() -> ListNode? {
        if array.isEmpty { return nil }
        
        return array.removeLast()
    }
}