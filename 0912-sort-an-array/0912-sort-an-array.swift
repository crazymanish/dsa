class Solution {
    func sortArray(_ nums: [Int]) -> [Int] {
        var nums = nums

        // O(log n)
        func siftDown(_ i: Int, _ n: Int) {
            let left = i * 2 + 1
            let right = i * 2 + 2
            
            var min = i
            if left < n, nums[i] < nums[left] {
                min = left
            }
            
            if right < n, nums[min] < nums[right] {
                min = right
            }
            
            guard min != i else { return }
            
            nums.swapAt(i, min)
            siftDown(min, n)
        }
        
        // O(n) // Heap Sort
        func heapify(_ n: Int) {
            for i in stride(from: n / 2, through: 0, by: -1) {
                siftDown(i, n)
            }
        }
        
        
        heapify(nums.count) // O(n)
        
        // O(n)
        for i in stride(from: nums.count - 1, through: 0, by: -1) { 
            nums.swapAt(0, i)
            siftDown(0, i) // O(log n)
        }
        
        // O(n) + O(n) * O(log n) = O(n log n)
        return nums
    }
}

/*
class Solution {
    func sortArray(_ nums: [Int]) -> [Int] {
        guard nums.count > 1 else { return nums }

        var lessNums: [Int] = []
        var equalNums: [Int] = []
        var greaterNums: [Int] = []

        // Quick Sort
        let middle = nums.count / 2
        let pivot = nums[middle]
        
        for num in nums {
            if num < pivot {
                lessNums.append(num)
            }
            if num == pivot {
                equalNums.append(num)
            }
            if num > pivot {
                greaterNums.append(num)
            }
        }

        return sortArray(lessNums) + equalNums + sortArray(greaterNums)
    }
}*/