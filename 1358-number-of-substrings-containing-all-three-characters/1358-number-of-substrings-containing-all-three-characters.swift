class Solution {    
    func numberOfSubstrings(_ s: String) -> Int {
        guard s.count > 2 else { return 0 }
        
        let chars = Array(s)
        let charsCount = chars.count
        var lead = 0
        var follow = 0
        var result = 0
        
        var hashMap: [Character: Int] = [
            "a": 0,
            "b": 0,
            "c": 0
        ]
        
        var hasAll: Bool { (hashMap["a"]! > 0 && hashMap["b"]! > 0 && hashMap["c"]! > 0) }
    
        func incrementChar(_ char: Character) {
            hashMap[char]! += 1
        }
    
        func decrementChar(_ char: Character) {
            hashMap[char] = max(hashMap[char]!-1, 0)        
        }
        
        while (follow < charsCount) {
            if (hasAll) {
                // all characters are there, update res and slide
                // start to the right.
                result += charsCount - lead + 1
                decrementChar(chars[follow])
                follow += 1
            } else if (lead == charsCount) {
                // arrived at the end and not all characters are 
                // present, we are done
                return result
            } else {
                // all characters are not present, slide end to the
                // right and add a new character
                incrementChar(chars[lead])
                lead += 1
            }
        }
        
        return result
    }
}