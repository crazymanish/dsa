class Solution {
    // O(n)/O(n^2), O(n)
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums
        
        func swap(_ firstIndex: Int, _ secondIndex: Int) {
            let temp = nums[firstIndex]
            nums[firstIndex] = nums[secondIndex]
            nums[secondIndex] = temp
        }
        
        func indexPartition(_ low: Int, _ high: Int) -> Int {
            let pivot = nums[high]
            var indexToPlace = low-1
        
            for currentIndex in low..<high {
                if nums[currentIndex] < pivot {
                    indexToPlace += 1
                    
                    swap(indexToPlace, currentIndex)
                }
            }
            indexToPlace += 1
        
            nums[high] = nums[indexToPlace]
            nums[indexToPlace] = pivot
        
            return indexToPlace
        }
        
        var low = 0
        var high = nums.count-1
        var indexPivot = indexPartition(low, high)
        
        let indexGoal = nums.count - k
        while indexPivot != indexGoal {
            if indexPivot < indexGoal {
                low = indexPivot + 1
            } else {
                high = indexPivot - 1
            }
            
            indexPivot = indexPartition(low, high)
        }
        
        return nums[indexPivot]
    }
    
    // One liner solution: O(n*logn), O(n)
    // func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    //     return nums.sorted()[nums.count - k]
    // }
}