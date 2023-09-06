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
    func splitListToParts(_ head: ListNode?, _ k: Int) -> [ListNode?] {
        // Count the total number of nodes in the linked list.
        var count = 0
        var currentNode = head
        while currentNode != nil {
            currentNode = currentNode?.next
            count += 1
        }

        // Calculate the minimum size of each part.
        let minPartSize = count / k
        // Calculate the number of parts with an extra node.
        let remainder = count % k

        // Iterate over each part.
        currentNode = head
        var result: [ListNode?] = []
        for i in 0..<k {
            // Add the head of the current part to the result list.
            result.append(currentNode)
            
            // Calculate the size of the current part.
            let partSize = minPartSize + (i < remainder ? 1 : 0)

            // Split the current part from the rest of the linked list.
            for j in 0..<partSize {
                let nextNode = currentNode?.next
                // Set the next pointer of the last node in the part to nil.
                if j == partSize - 1 {
                    currentNode?.next = nil
                }
                currentNode = nextNode
            }
        }

        return result
    }
}