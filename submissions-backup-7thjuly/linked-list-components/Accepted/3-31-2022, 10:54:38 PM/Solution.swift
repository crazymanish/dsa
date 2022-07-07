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
        var numsHashMap: [Int : Bool] = [:]
        for num in nums { numsHashMap[num] = true }
        
        var output = 0
        var previosNode: ListNode? = nil
        var currentNode = head

        while currentNode != nil {
            let curretNodeValue = currentNode!.val
            
            if previosNode == nil {
                if numsHashMap[curretNodeValue] != nil { output += 1 }  
            } else {
                let previousNodeValue = previosNode!.val
                if numsHashMap[previousNodeValue] == nil && numsHashMap[curretNodeValue] != nil { output += 1 } 
            }
            
            previosNode = currentNode
            currentNode = currentNode?.next
        }
        
        return output
    }
}