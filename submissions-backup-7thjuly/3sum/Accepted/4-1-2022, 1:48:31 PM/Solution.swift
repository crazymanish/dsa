// https://leetcode.com/problems/3sum

class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var output: [[Int]] = []
        let sortedNums = nums.sorted()
        let sortedNumsCount = sortedNums.count

        guard sortedNumsCount > 2 else { return output }

        for i in 0..<sortedNumsCount - 2 {
            if i > 0, sortedNums[i] == sortedNums[i - 1] { continue } // skip Duplicate

            var j = i + 1
            var k = sortedNumsCount - 1

            while j < k {
                let target = sortedNums[i] + sortedNums[j] + sortedNums[k]
                if (target == 0) {
                    if j - 1 > i, sortedNums[j] == sortedNums[j - 1] { // skip Duplicate
                        j += 1
                        continue
                    }
                    output.append([sortedNums[i], sortedNums[j], sortedNums[k]])
                    j += 1
                } else if (target < 0) {
                    j += 1
                } else {
                    k -= 1
                }
            }
        }

        return output
    }
}