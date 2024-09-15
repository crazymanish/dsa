import Algorithms

class Solution {
    func findTheLongestSubstring(_ s: String) -> Int {
		// map `s` vowels into bits; consonants mapped to zero
        let s = s.map{["a":1, "e":2, "i":4, "o":8, "u":16][$0] ?? 0}
		
        // compute prefix XORS using Swift Algorithm
        let prefixXors = s.reductions(0, ^)
        var firstIndex = [Int:Int]()
        var result = 0
        
        for (i,n) in prefixXors.enumerated() {
            firstIndex[n] = firstIndex[n] ?? i
            result = max(result, i - firstIndex[n]!)
        }
        
        return result
    }
}