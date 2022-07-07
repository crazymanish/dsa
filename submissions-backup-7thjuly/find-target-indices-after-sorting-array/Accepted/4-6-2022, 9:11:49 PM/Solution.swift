// https://leetcode.com/problems/find-target-indices-after-sorting-array

class Solution {
    func targetIndices(_ nums: [Int], _ target: Int) -> [Int] {
        return nums
            .sorted()
            .enumerated()
            .compactMap { (index, element) in 
                         element == target ? index : nil 
                        }
    }
}