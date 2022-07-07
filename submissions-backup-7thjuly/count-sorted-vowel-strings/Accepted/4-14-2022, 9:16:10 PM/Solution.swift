// https://leetcode.com/problems/count-sorted-vowel-strings

class Solution {
    func countVowelStrings(_ n: Int) -> Int {
        if n == 1 { return 5 }

        var dpMatrix = Array(repeating: Array(repeating: 0, count: 6), count: n-1)
        
        // Set Default value
        for index in 0...5 { dpMatrix[0][index] = 1 }
        dpMatrix[0][0] = 0

        for num in 1..<n-1 {
            for index in 1...5 {
                dpMatrix[num][index] = dpMatrix[num][index-1] + dpMatrix[num-1][index]
            }
        }

        // dpMatrix last-row will have the answer (count of vowels for n)
        // a*5 + e*4 + i*3 + o*2 + u*1
        return dpMatrix[n-2][1] * 5 + dpMatrix[n-2][2] * 4 + dpMatrix[n-2][3] * 3 + dpMatrix[n-2][4] * 2 + dpMatrix[n-2][5]
    }
}