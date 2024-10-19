class Solution {
    func findKthBit(_ n: Int, _ k: Int) -> Character {
        var s = [0]
        
        while k >= s.count {
            s += [1] + s.reversed().map{$0^1}
        }
        
        return Array("01")[s[k-1]]
    }
}