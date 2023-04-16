class Solution {
    func numWays(_ words: [String], _ target: String) -> Int {
        let modulo = Int(1e9 + 7)
        var target = Array(target)

        let n = words[0].count
        let k = target.count

        // charArray[i][j] means, how many char i at word[j] in words
        var charArray = Array(
            repeating: Array(repeating: 0, count: n),
            count: 26
        )

        let characterA = Character("a").asciiValue!
        for word in words {
            var wordArray = Array(word)
            for i in 0..<n {
                let index = Int(wordArray[i].asciiValue! - characterA)
                charArray[index][i] += 1
            }
        }

        // dp[i][j], number of ways use 0...i index to form target[0...k]
        var dp = Array(
            repeating: Array(repeating: 0, count: k),
            count: n
        )

		// index to help quick find next starting of i
        var index = 0
        for j in 0..<k {
            var temp = -1
            for i in index..<n {
                // print("i", i)
                let c = Int(target[j].asciiValue! - characterA)
                let val = charArray[c][i]
                if val > 0, temp == -1 {
                    temp = i
                }
                
                dp[i][j] = (dp[i][j] + (i > 0 ? dp[i-1][j] : 0) + val * (i > 0 && j > 0 ? dp[i-1][j-1] : 1)) % modulo
            }

            // temp == -1 means cannot find next proper index
            if temp == -1 { return 0 }
            index = temp + 1
            // print(index, j )
        }

        // print(dp)
        return dp[n-1][k-1]
    }
}