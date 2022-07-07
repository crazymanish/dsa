// https://leetcode.com/problems/swapping-nodes-in-a-linked-list

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
    func swapNodes(_ head: ListNode?, _ k: Int) -> ListNode? {
        if head == nil { return nil }
        
        var nodeValues: [Int] = []
        var currentNode = head
        while currentNode != nil {
            nodeValues.append(currentNode!.val)
            currentNode = currentNode?.next
        }
        
        // Swapping time
        let nodeCount = nodeValues.count 
        let temp = nodeValues[k-1]
        nodeValues[k-1] = nodeValues[nodeCount-k]
        nodeValues[nodeCount-k] = temp
        
        // re-create List
        return createList(nodeValues, nodeCount, 0)
    }
    
    private func createList(_ array: [Int], _ count: Int, _ index: Int) -> ListNode? {
        guard index < count else { return nil }
        
        let currentIndexValue = array[index]
        let nextNode = createList(array, count, index+1)
        
        return ListNode(currentIndexValue, nextNode)
    }
}