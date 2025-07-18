/*
Time Complexity: O(N * log N)
- The algorithm makes two main passes through the array. In each pass, it performs roughly N heap operations (inserting or removing elements).
- Each heap operation costs O(log N), as the heap's size is proportional to N.
- Therefore, the total time is dominated by these heap operations, resulting in N * O(log N).

Space Complexity: O(N)
- The solution uses two heaps and an auxiliary array (minPrefixSums) to store intermediate results.
- The size of the heaps and the array are both proportional to N/3, which simplifies to O(N).
*/
class Solution {
    func minimumDifference(_ nums: [Int]) -> Int {
        let totalCount = nums.count
        let partitionSize = totalCount / 3

        // --- Pass 1: Calculate minimum prefix sums (left-to-right) ---
        // minPrefixSums[i] will store the minimum sum of `partitionSize` elements
        // from the prefix nums[0...i-1].
        var minPrefixSums = [Int](repeating: 0, count: totalCount + 1)
        
        // A max-heap helps us efficiently track the `partitionSize` smallest elements.
        var leftHeap = Heap<Int>({ $0 > $1 })
        var currentMinPrefixSum = 0
        
        for i in 0..<(2 * partitionSize) {
            currentMinPrefixSum += nums[i]
            leftHeap.push(nums[i])
            
            // If the heap grows too large, remove the biggest element to keep the sum minimal.
            if leftHeap.count > partitionSize {
                if let maxVal = leftHeap.pop() {
                    currentMinPrefixSum -= maxVal
                }
            }
            
            if leftHeap.count == partitionSize {
                minPrefixSums[i + 1] = currentMinPrefixSum
            }
        }
        
        // --- Pass 2: Calculate max suffix sums and find the result (right-to-left) ---
        var minDifference = Int.max
        
        // A min-heap helps us efficiently track the `partitionSize` largest elements.
        var rightHeap = Heap<Int>({ $0 < $1 })
        var currentMaxSuffixSum = 0
        
        for i in (partitionSize..<totalCount).reversed() {
            currentMaxSuffixSum += nums[i]
            rightHeap.push(nums[i])
            
            // If the heap grows too large, remove the smallest element to keep the sum maximal.
            if rightHeap.count > partitionSize {
                if let minVal = rightHeap.pop() {
                    currentMaxSuffixSum -= minVal
                }
            }

            // Once we have a valid suffix of size `partitionSize`, we can calculate a candidate difference.
            if rightHeap.count == partitionSize {
                let difference = minPrefixSums[i] - currentMaxSuffixSum
                minDifference = min(minDifference, difference)
            }
        }

        return minDifference
    }
}

struct Heap<T> {
    var data = [T]()
    let areSorted: (T, T) -> Bool

    init(_ sort: @escaping (T, T) -> Bool) {
        self.areSorted = sort
    }

    var count: Int { data.count }
    
    mutating func push(_ val: T) {
        data.append(val)
        siftUp(data.count - 1)
    }
    
    mutating func pop() -> T? {
        guard !data.isEmpty else { return nil }
        
        data.swapAt(0, data.count - 1)

        let val = data.removeLast()
        siftDown(0)
        
        return val
    }
    
    mutating func siftUp(_ i: Int) {
        var child = i
        var parent = (child - 1) / 2
        
        while child > 0 && !areSorted(data[parent], data[child]) {
            data.swapAt(parent, child)
            child = parent
            parent = (child - 1) / 2
        }
    }

    mutating func siftDown(_ i: Int) {
        var parent = i
        
        while true {
            let left = 2*parent + 1, right = left + 1
            var candidate = parent
        
            if left < data.count && !areSorted(data[candidate], data[left]) {
                candidate = left
            }
        
            if right < data.count && !areSorted(data[candidate], data[right]) {
                candidate = right
            }
        
            guard candidate != parent else { break }
            
            data.swapAt(parent, candidate)
            parent = candidate
        }
    }
}