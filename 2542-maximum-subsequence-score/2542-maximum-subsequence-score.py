class Solution:
    def maxScore(self, nums1: List[int], nums2: List[int], k: int) -> int:
        res, prefixSum, maxHeap = 0, 0, []
        
        for a, b in sorted(list(zip(nums1, nums2)), key=itemgetter(1), reverse=True):
            prefixSum += a
            heappush(maxHeap, a)
            if len(maxHeap) == k:
                res = max(res, prefixSum * b)
                prefixSum -= heappop(maxHeap)                               
        return res
    
    
"""
class Solution {
    func maxScore(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> Int {
        var result = 0
        var prefixSum = 0
        var maxHeap = Heap<Int>(elements: [], sort: { $0 > $1 })
        
        let abc = zip(nums1, nums2).sorted {$0.1 > $1.1}
        print(abc)
        
        for (a, b) in zip(nums1, nums2).sorted {$0.1 > $1.1} {
            prefixSum += a
            maxHeap.push(a)
            
            if (maxHeap.size == k) {
                result = max(result, prefixSum * b)
                prefixSum -= maxHeap.pop()!
            }
        }
        
        return result
    }
}

struct Heap<T: Comparable> {
    var elements = [T]()
    private var sort: (_ left: T, _ right: T) -> Bool

    public var peek: T? {
        return elements.first
    }

    public var size: Int {
        return elements.count
    }

    init(elements: [T], sort: @escaping (_ left: T, _ right: T) -> Bool) {
        self.elements = elements
        self.sort = sort
        self.build()
    }

    private mutating func build() {
        for index in stride(from: elements.count/2 - 1, through: 0, by: -1) {
            self.shiftDown(at: index)
        }
    }

    private mutating func shiftDown(at index: Int) {
        var parent = index
        while true {
            let left = self.leftChild(of: parent)
            let right = self.rightChild(of: parent)
            var candidate = parent
            if left < self.elements.count && sort(elements[left], elements[candidate]) {
                candidate = left
            }
            if right < self.elements.count && sort(elements[right], elements[candidate]) {
                candidate = right
            }
            if candidate == parent { return }
            elements.swapAt(candidate, parent)
            parent = candidate
        }
    }

    private mutating func shiftUp(at index: Int) {
        var candidate = index
        var parent = self.parent(of: candidate)
        while candidate > 0 && sort(elements[candidate], elements[parent]) {
            elements.swapAt(candidate, parent)
            candidate = parent
            parent = self.parent(of: candidate)
        }
    }

    public mutating func push(_ element: T) {
        elements.append(element)
        self.shiftUp(at: self.elements.count - 1)
    }

    public mutating func pop() -> T? {
        guard !elements.isEmpty else { return nil }
        elements.swapAt(0, self.elements.count - 1)
        let lastElement = self.elements.removeLast()
        self.shiftDown(at: 0)
        return lastElement
    }

    private func parent(of index: Int) -> Int {
        return (index-1)/2
    }

    private func leftChild(of index: Int) -> Int {
        return 2*index + 1
    }

    private func rightChild(of index: Int) -> Int {
        return 2*index + 2
    }
}
"""