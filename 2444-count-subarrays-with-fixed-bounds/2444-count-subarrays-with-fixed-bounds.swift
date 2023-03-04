class Solution {
    func countSubarrays(_ nums: [Int], _ minK: Int, _ maxK: Int) -> Int {
        func getCountWithInRangeArray(_ num: [Int]) -> Int {
            var result = 0
            var maxIndexSuffix = Array(repeating: 0, count: num.count)
            var minIndexSuffix = Array(repeating: 0, count: num.count)
            var i = num.count - 1
            
            while i >= 0 {
                minIndexSuffix[i] = num[i] == minK ? i : (i == num.count - 1 ? Int.max : minIndexSuffix[i + 1])
                maxIndexSuffix[i] = num[i] == maxK ? i : (i == num.count - 1 ? Int.max : maxIndexSuffix[i + 1])
                i -= 1
            }
        
            for j in 0 ..< num.count {
                let completeArrEndIndex = max(minIndexSuffix[j], maxIndexSuffix[j])
            
                if completeArrEndIndex == Int.max {
                    // this means there is eighter minK or maxK is missing.
                    continue
                }
                result += (num.count - completeArrEndIndex)
            }
            return result
        }
        
        var array = [Int]()
        var result = 0
        for n in nums {
            if minK <= n && n <= maxK {
                array.append(n)
                continue
            }
            result += getCountWithInRangeArray(array)
            array.removeAll()
        }
        // for the case when all the elements in the array are in the range
        result += getCountWithInRangeArray(array)
        
        return result
    }
}