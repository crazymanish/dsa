class Solution {
    func knightDialer(_ n: Int) -> Int {
        guard n > 1 else { return 10 }

        let mod = 1_000_000_007

        // The code is based on the fact that most of the digits
        // can form a group because their options are identical.
        // This simplifies calculations. We can also ignore digit 5
        // as it can't be linked to any other digits.
        var a = 4 // 1,3,7,9
        var b = 2 // 2,8
        var c = 2 // 4,6
        var d = 1 // 0

        for _ in 2...n {
            (a, b, c, d) = (2*(b+c)%mod, a, (a+2*d)%mod, c)
        }

        return (a+b+c+d)%mod
    }
}