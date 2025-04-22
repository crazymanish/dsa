class Solution {
    let mod = Int(1e9 + 7)
    var dp = [[Int]](repeating: [Int](repeating: 0, count: 10001), count: 15)
    var pr = [[Int]](repeating: [Int](repeating: 0, count: 10001), count: 15)
    var tot = [Int](repeating: 0, count: 15)
    var n = 0, mx = 0

    func get(_ la: Int, _ cn: Int) {
        tot[cn] += 1
        var p = 2 * la
        while p <= mx {
            get(p, cn + 1)
            p += la
        }
    }

    func idealArrays(_ nn: Int, _ mmx: Int) -> Int {
        n = nn
        mx = mmx

        for i in 1...10000 {
            dp[1][i] = 1
            pr[1][i] = i
        }

        for i in 2..<15 {
            for j in i...10000 {
                dp[i][j] = pr[i - 1][j - 1]
                pr[i][j] = (dp[i][j] + pr[i][j - 1]) % mod
            }
        }

        for i in 1...mx {
            get(i, 1)
        }

        var ans = mx
        for i in 2..<15 {
            let x = (tot[i] * dp[i][n]) % mod
            ans = (ans + x) % mod
        }

        return ans
    }
}