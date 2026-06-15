/**
 * Problem Summary:
 * Given the head of a singly linked list, delete the middle node and return the head.
 * For a list of length n, the middle node is at index n / 2 using 0-based indexing.
 *
 * Strategy:
 * Use the fast and slow pointer technique.
 * - `fastPointer` moves two steps at a time.
 * - `previousToMiddle` moves one step at a time.
 * When `fastPointer` reaches the end, `previousToMiddle.next` points to the middle node.
 * Then skip the middle node by updating the next pointer.
 *
 * Time Complexity: O(n)
 * Space Complexity: O(1)
 */
class Solution {
    func deleteMiddle(_ head: ListNode?) -> ListNode? {
        // A list with 0 or 1 node becomes empty after deleting the middle.
        guard let head, head.next != nil else { return nil }

        let dummyHead = ListNode(-1, head)

        var previousToMiddle: ListNode? = dummyHead
        var fastPointer: ListNode? = head

        // Move fast by 2 steps and previousToMiddle by 1 step.
        // When fast reaches the end, previousToMiddle is right before the middle node.
        while fastPointer?.next != nil {
            previousToMiddle = previousToMiddle?.next
            fastPointer = fastPointer?.next?.next
        }

        // Delete the middle node by skipping it.
        previousToMiddle?.next = previousToMiddle?.next?.next

        return dummyHead.next
    }
}