import Collections

class Solution {
    func minOperations(_ nums: [Int], _ k: Int) -> Int {
        var minHeap = Heap<Int>(nums) // Initialize a min-heap with the input numbers
        var operations = 0

        // Continue as long as there are at least two elements and the smallest element is less than k
        while minHeap.count > 1 {
            let smallest = minHeap.removeMin() // Remove the smallest element
            let secondSmallest = minHeap.removeMin()  // Remove the second smallest element
            let newValue = min(smallest, secondSmallest) * 2 + max(smallest, secondSmallest) // Calculate the new value

            guard smallest < k else { break }
            
            minHeap.insert(newValue) // Insert the new value back into the heap
            operations += 1 // Increment the operation count
        }
        
        return operations // Return the total number of operations
    }
}