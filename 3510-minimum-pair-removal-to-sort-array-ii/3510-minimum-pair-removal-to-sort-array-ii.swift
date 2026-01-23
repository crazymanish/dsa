class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n log n)
    ///     - Each merge operation involves heap insertions/removals.
    ///     - At most (n - 1) merges occur.
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     - Heap, linked list nodes, and removed set.
    ///
    /// Problem Summary:
    ///   Repeatedly merge the adjacent pair with the minimum sum
    ///   until the array becomes non-decreasing.
    ///   Return the number of merge operations performed.
    ///
    /// Optimized Strategy:
    ///   - Maintain a min-heap of adjacent pairs by sum.
    ///   - Track the array as a doubly linked list of nodes.
    ///   - Maintain a count of "decreasing positions".
    ///   - Stop when no decreasing positions remain.
    /// -----------------------------------------------------------------------
    func minimumPairRemoval(_ nums: [Int]) -> Int {
        let count = nums.count
        
        // Tracks which original indices have been removed
        var removedIndices = Set<Int>()
        
        // Min-heap of adjacent pairs ordered by sum
        var minPairHeap = Heap<AdjacentPair>()
        
        // Number of positions where array is decreasing
        var decreasingPairs = 0
        
        // Build initial linked list of nodes
        var currentNode = ListNode(nums[0], 0)
        
        for index in 1..<count {
            if nums[index] < nums[index - 1] {
                decreasingPairs += 1
            }
            
            let nextNode = ListNode(nums[index], index)
            let pair = AdjacentPair(
                nums[index - 1] + nums[index],
                currentNode,
                nextNode
            )
            
            minPairHeap.insert(pair)
            currentNode = nextNode
        }
        
        // Merge until array becomes non-decreasing
        while decreasingPairs > 0 {
            guard let smallestPair = minPairHeap.popMin() else { break }
            
            let leftNode = smallestPair.leftNode
            let rightNode = smallestPair.rightNode
            
            // Skip invalid / outdated pairs
            if removedIndices.contains(leftNode.index) ||
               removedIndices.contains(rightNode.index) ||
               leftNode.value + rightNode.value != smallestPair.sum {
                continue
            }
            
            // Fix decreasing count caused by this pair
            if leftNode.value > rightNode.value {
                decreasingPairs -= 1
            }
            
            // Handle left neighbor
            if let previousNode = leftNode.previous {
                let newPair = AdjacentPair(
                    previousNode.value + smallestPair.sum,
                    previousNode,
                    leftNode
                )
                minPairHeap.insert(newPair)
                
                // Adjust decreasing count based on merge effect
                if previousNode.value > leftNode.value {
                    if previousNode.value <= smallestPair.sum {
                        decreasingPairs -= 1
                    }
                } else {
                    if previousNode.value > smallestPair.sum {
                        decreasingPairs += 1
                    }
                }
            }
            
            // Handle right neighbor
            if let nextNode = rightNode.next {
                let newPair = AdjacentPair(
                    nextNode.value + smallestPair.sum,
                    leftNode,
                    nextNode
                )
                minPairHeap.insert(newPair)
                
                if nextNode.value < rightNode.value {
                    if nextNode.value >= smallestPair.sum {
                        decreasingPairs -= 1
                    }
                } else {
                    if nextNode.value < smallestPair.sum {
                        decreasingPairs += 1
                    }
                }
            } else {
                // Rightmost node removed
                leftNode.next = nil
            }
            
            // Perform merge:
            //   - left node absorbs right node
            //   - right node is removed
            leftNode.value = smallestPair.sum
            removedIndices.insert(rightNode.index)
        }
        
        // Number of merges = number of removed elements
        return removedIndices.count
    }
}

struct AdjacentPair: Comparable {
    let sum: Int
    let leftNode: ListNode
    let rightNode: ListNode
    
    init(_ sum: Int, _ leftNode: ListNode, _ rightNode: ListNode) {
        self.sum = sum
        self.leftNode = leftNode
        self.rightNode = rightNode
        
        // Maintain linked list connections
        self.leftNode.next = rightNode
        self.rightNode.previous = leftNode
    }
    
    static func == (lhs: AdjacentPair, rhs: AdjacentPair) -> Bool {
        return (lhs.sum, lhs.leftNode.index) == (rhs.sum, rhs.leftNode.index)
    }
    
    static func < (lhs: AdjacentPair, rhs: AdjacentPair) -> Bool {
        return (lhs.sum, lhs.leftNode.index) < (rhs.sum, rhs.leftNode.index)
    }
}

final class ListNode {
    var value: Int
    let index: Int
    var previous: ListNode?
    var next: ListNode?
    
    init(
        _ value: Int,
        _ index: Int,
        _ previous: ListNode? = nil,
        _ next: ListNode? = nil
    ) {
        self.value = value
        self.index = index
        self.previous = previous
        self.next = next
    }
}
