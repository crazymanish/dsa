class Solution {
    func minimumDeviation(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        
        var array = [Int]()
        
        // binary search insert
        func insert(_ target: Int) {
            if array.isEmpty {
                array.append(target)
                return
            }
        
            var left = 0
            var right = array.count-1
            while left < right {
                let mid = left+(right-left)/2
            
                if array[mid] < target {
                    left = mid + 1
                } else {
                    right = mid
                }
            }
        
		    // this is for avoid insert duplicate element
            if array[left] == target {
                return
            } else if array[left] < target {
                array.insert(target, at: left+1)
            } else {
                array.insert(target, at: left)
            }
        }
        
        for n in nums {
            insert(n % 2 == 0 ? n : n*2)
        }
        
        var result = array.last! - array.first!
        
        while array.last! % 2 == 0 {
            insert(array.last!/2)
            array.removeLast()
            result = min(result, array.last! - array.first!)
        }
        
        return result
    }
}