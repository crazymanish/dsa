class Solution {
    func passThePillow(_ n: Int, _ time: Int) -> Int {
        let period = 2 * (n-1)
        
        if time >= period { return passThePillow(n, time%period) }

        if time <= n-1 {
            // Passing to the right.
            return time+1
        } else {
            // Passing to the left.
            return 2 * (n-1) - time+1
        }
    }
}