class Solution {
    func canArrange(_ arr: [Int], _ k: Int) -> Bool {
        // `k` == 1 is degenerate, all values end up in `freq[0]` and `arr.count` is guaranteed to be even.
        guard k > 1 else { return true }
        
        // mod function that returns positive mods for negative values
        let absMod = {a in (a%k+k)%k}

        // build frequency map
        let freq = [Int:Int](arr.map{ (absMod($0),1) }, uniquingKeysWith:+)
                
        // `freq[0]` must be even, since all contributing `arr` elements pair with each other
        if let f = freq[0], f % 2 != 0 { return false }
        
        // all pairs of keys in `freq` that add up to `k` must have equal values (or pairing of `arr` elements isn't possible).
        return (1...k/2).allSatisfy{i in freq[i] == freq[k-i]}
    }
}