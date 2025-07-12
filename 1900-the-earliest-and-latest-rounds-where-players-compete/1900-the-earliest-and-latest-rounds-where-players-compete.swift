class Solution {

    private var F = Array(repeating: Array(repeating: Array(repeating: 0, count: 30), count: 30), count: 30)
    private var G = Array(repeating: Array(repeating: Array(repeating: 0, count: 30), count: 30), count: 30)

    private func dp(_ n: Int, _ f: Int, _ s: Int) -> [Int] {
        if F[n][f][s] != 0 {
            return [F[n][f][s], G[n][f][s]]
        }

        if f + s == n + 1 {
            return [1, 1]
        }

        // F(n, f, s) == F(n, n + 1 - s, n + 1 - f)
        if f + s > n + 1 {
            let res = dp(n, n + 1 - s, n + 1 - f)
            F[n][f][s] = res[0]
            G[n][f][s] = res[1]
            return [F[n][f][s], G[n][f][s]]
        }

        var earliest = Int.max
        var latest = Int.min
        let nHalf = (n + 1) / 2

        if s <= nHalf {
            // On the left or in the middle
            for i in 0 ..< f {
                for j in 0 ..< s - f {
                    let res = dp(nHalf, i + 1, i + j + 2)
                    earliest = min(earliest, res[0])
                    latest = max(latest, res[1])
                }
            }
        } else {
            // s on the right
            let sPrime = n + 1 - s
            let mid = (n - 2 * sPrime + 1) / 2
            for i in 0 ..< f {
                for j in 0 ..< sPrime - f {
                    let res = dp(nHalf, i + 1, i + j + mid + 2)
                    earliest = min(earliest, res[0])
                    latest = max(latest, res[1])
                }
            }
        }

        F[n][f][s] = earliest + 1
        G[n][f][s] = latest + 1
        return [F[n][f][s], G[n][f][s]]
    }

    func earliestAndLatest(_ n: Int, _ firstPlayer: Int, _ secondPlayer: Int) -> [Int] {
        // F(n, f, s) == F(n, s, f)
        var f = firstPlayer
        var s = secondPlayer
        if firstPlayer > secondPlayer {
            f = secondPlayer
            s = firstPlayer
        }

        return dp(n, f, s)
    }
}