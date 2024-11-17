import Algorithms
import Collections

struct HeapItem:Comparable {
    var sum,index:Int
    
    static func <(a:Self, b:Self)->Bool { a.sum < b.sum }
}

class Solution {
    func shortestSubarray(_ nums: [Int], _ k: Int) -> Int {
        let prefixSums = nums.reductions(+)
        var minLength = Int.max
        var heap = Heap<HeapItem>()

        for (i,prefixSum) in prefixSums.enumerated() {
            if prefixSum >= k, minLength > i+1 {
                minLength = i+1 
            }
            
            while let item = heap.min, prefixSum-item.sum >= k {
                minLength = min(minLength, i-item.index)
                heap.popMin()
            }
            heap.insert(HeapItem(sum:prefixSum, index:i))
        }
        
        return minLength == .max ? -1 : minLength
    }
}

/*
- Swift Heap data structure reference: https://swiftpackageindex.com/apple/swift-collections/1.1.0/documentation/heapmodule/heap
- Using .reductions() to create prefix sums. Reference: https://swiftpackageindex.com/apple/swift-algorithms/1.2.0/documentation/algorithms/reductions
*/