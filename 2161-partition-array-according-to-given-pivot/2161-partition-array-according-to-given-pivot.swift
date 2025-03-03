class Solution {
    func pivotArray(_ nums: [Int], _ pivot: Int) -> [Int] {
        var result: [Int] = []
        
        // Add elements less than pivot
        for num in nums where num < pivot {
            result.append(num)
        }
        
        // Add elements equal to pivot
        for num in nums where num == pivot {
            result.append(num)
        }
        
        // Add elements greater than pivot
        for num in nums where num > pivot {
            result.append(num)
        }

        return result
    }
}