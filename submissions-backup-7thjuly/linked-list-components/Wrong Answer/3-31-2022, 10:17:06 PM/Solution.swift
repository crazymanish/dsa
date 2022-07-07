// https://leetcode.com/problems/linked-list-components

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
    func numComponents(_ head: ListNode?, _ nums: [Int]) -> Int {
        var hashMap: [Int : Bool] = [:]
        for num in nums { hashMap[num] = true }
        
        var output = 0
        var currentNode = head
        
        while currentNode?.next != nil {
            let currentNodeValue = currentNode!.val
            let nextNodeValue = currentNode!.next!.val
            
            if hashMap[currentNodeValue] != nil || hashMap[nextNodeValue] != nil {
                output += 1
            }
            
            currentNode = currentNode!.next!.next
        }
        
        return output
    }
}