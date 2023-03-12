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
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        if(lists.count == 0) { return nil }
        if(lists.count == 1) { return lists[0] }
        
        func mergeTwoLists(_ list1:ListNode?, _ list2:ListNode?) ->ListNode? {
            guard let list1 = list1 else { return list2 } 
            guard let list2 = list2 else { return list1 }

            var head = list1
            if list1.val < list2.val {
                head.next = mergeTwoLists(list1.next, list2)
            } else {
                head = list2
                head.next = mergeTwoLists(list1, list2.next)     
            }

            return head
        }
        
        func mergeLists(_ start:Int, _ end:Int) -> ListNode? {
            if(start == end) { return lists[start] }
        
            if(start < end) {
                let middle = (start+end)/2
                let list1 = mergeLists(start, middle)
                let list2 = mergeLists(middle+1, end)
                return mergeTwoLists(list1, list2)
            }
        
            return nil
        }
        
        return mergeLists(0, lists.count-1)
    }
}