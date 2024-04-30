class Solution {
    func wonderfulSubstrings(_ word: String) -> Int {
        let word = word.map({ Int($0.asciiValue ?? 97) - 97 }) // a...j -> 0...9
        let maxChar = 10 // j is 10-th char
        var mask = 0 // prefix patiry mask
        
        var result = 0 // number of wonderful substrings
        
        var dpCache = [Int](repeating: 0, count: 1 << maxChar) // prefix parity mask counts
        dpCache[0] = 1 // for empty substring at start
        
        for char in word {
            mask ^= 1 << char // change char parity in mask
            result += dpCache[mask] // prior substrings with same parity mask
            
            for i in 0..<maxChar {
                result += dpCache[mask ^ (1 << i)] // prior substrings with one-bit-diff parity mask
            }
            
            dpCache[mask] += 1 // remember parity mask
        }
        
        return result
    }
}