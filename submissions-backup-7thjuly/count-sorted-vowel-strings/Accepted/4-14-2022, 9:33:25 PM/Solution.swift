// https://leetcode.com/problems/count-sorted-vowel-strings

class Solution {
    func countVowelStrings(_ n: Int) -> Int {
        if n == 1 { return 5 }

        var dpCacheRow = Array(repeating: 1, count: 5)

        for num in 1..<n-1 {
            for index in 1..<5 {
                dpCacheRow[index] = dpCacheRow[index-1] + dpCacheRow[index]
            }
        }

        // dp row will have the answer (count of vowels for n)
        // a*5 + e*4 + i*3 + o*2 + u*1
        return dpCacheRow[0] * 5 + dpCacheRow[1] * 4 + dpCacheRow[2] * 3 + dpCacheRow[3] * 2 + dpCacheRow[4]
    }
}