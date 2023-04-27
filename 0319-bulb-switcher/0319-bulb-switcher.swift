class Solution {
    func bulbSwitch(_ n: Int) -> Int {
        var i = 0
        
        while i*i < n {
            i += 1
        }
        
        return i*i == n ? i : i-1
    }
}