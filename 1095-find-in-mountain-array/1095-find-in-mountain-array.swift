/**
 * // This is MountainArray's API interface.
 * // You should not implement it, or speculate about its implementation
 * interface MountainArray {
 *     public func get(_ index: Int) -> Int {}
 *     public func length() -> Int {}
 * }
 */

class Solution {
    func findInMountainArray(_ target: Int, _ mountainArray: MountainArray) -> Int {  
        let n = mountainArray.length()
        
        if target < mountainArray.get(0) && target < mountainArray.get(n-1) {
            return -1
        }
        
        let peakIndex = mountainArray.peak()
        
        let left = mountainArray.binarySearch(target, 0, peakIndex)
        if left != -1 { return left }
        
        let right = mountainArray.binarySearchReverse(target, peakIndex, n-1)
        return right
    }
}

extension MountainArray {
    //: Find Peak Element - https://leetcode.com/problems/find-peak-element/
    func peak() -> Int {
        var start = 0
        var end = self.length() - 1
        
        while start < end {
            let mid = start + (end-start) / 2
            
            if get(mid) > get(mid+1) {
                end = mid
            } else {
                start = mid+1
            }
        }
        
        return start
    }
    
    //: Standard binary search
    func binarySearch(_ target: Int, _ start: Int, _ end: Int) -> Int {
        var start = start
        var end = end
        
        while start <= end {
            let mid = start + (end-start) / 2
            
            if get(mid) == target {
                return mid
            } else if get(mid) < target {
                start = mid+1
            } else {
                end = mid-1
            }
        }
        
        return -1
    }
    
    //: Reverse binary search
    func binarySearchReverse(_ target: Int, _ start: Int, _ end: Int) -> Int {
        var start = start
        var end = end
        
        while start <= end {
            let mid = start + (end-start) / 2
            
            if get(mid) == target {
                return mid
            } else if get(mid) > target {
                start = mid+1
            } else {
                end = mid-1
            }
        }
        
        return -1
    }
}