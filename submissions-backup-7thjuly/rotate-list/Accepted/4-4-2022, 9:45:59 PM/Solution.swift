// https://leetcode.com/problems/rotate-list

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
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard head?.next != nil else { return head }

        var currentNode = head
        var nodesCount = 1

        while currentNode?.next != nil {
            currentNode = currentNode?.next
            nodesCount += 1
        }
        currentNode?.next = head // append list to the end

        var index = 0 
        while index < (nodesCount - k % nodesCount) { 
            currentNode = currentNode?.next
            index += 1
        }

        var newHead = currentNode?.next
        currentNode?.next = nil

        return newHead
    }
}