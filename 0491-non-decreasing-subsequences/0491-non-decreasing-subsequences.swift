class Solution {
    func findSubsequences(_ nums: [Int]) -> [[Int]] {
        var subsequences = Set<[Int]>()

        func backtracking(_ currentIndex: Int, _ subsequence: [Int]) {
            if currentIndex == nums.count + 1 { return }
            
            if subsequence.count >= 2 { subsequences.insert(subsequence) }
            
            for index in currentIndex..<nums.count {
                let currentNum = nums[index]
                if (subsequence.last ?? Int.min) <= currentNum {
                    backtracking(index + 1, subsequence + [currentNum])   
                }
            }
        }

        backtracking(0, [])
        return Array(subsequences)
    }
}