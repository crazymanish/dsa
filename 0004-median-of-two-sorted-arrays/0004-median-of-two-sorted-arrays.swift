class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        guard nums1.count <= nums2.count else { return findMedianSortedArrays(nums2, nums1) }
    
        let x = nums1.count
        let y = nums2.count
        var low = 0
        var high = x
    
        while low <= high {
            let partionX = (low + high) / 2
            let partionY = ((x + y + 1) / 2) - partionX
        
            let maxLeftX = partionX == 0 ? Int.min : nums1[partionX - 1]
            let minRightX = partionX == x ? Int.max : nums1[partionX]
        
            let maxLeftY = partionY == 0 ? Int.min : nums2[partionY - 1]
            let minRightY = partionY == y ? Int.max : nums2[partionY]
        
            if maxLeftX <= minRightY && maxLeftY <= minRightX {
                if ((x + y) % 2) == 0 {
                    var val1 = Double(max(maxLeftX,maxLeftY))
                    var val2 = Double(min(minRightX,minRightY))
                    return  (val1 + val2) / 2
                } else {
                    return Double(max(maxLeftX,maxLeftY))
                }
            } else if maxLeftX > minRightY {
                high = partionX - 1
            } else {
                low = partionX + 1
            }
        }
        
        return -1.0
    }
}