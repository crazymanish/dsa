class Solution {
    func smallestEquivalentString(_ s1: String, _ s2: String, _ baseStr: String) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyz"
        
        var hashMap: [Character : Character] = [:]
        for character in characters { 
            hashMap[character] = character 
        }
        
        func findMapping(_ character: Character) -> Character {
            if hashMap[character]! == character { return character }
        
            hashMap[character] = findMapping(hashMap[character]!)
            return hashMap[character]!
        }
        
        func performUnion(_ character1: Character, _ character2: Character) {
            var character1 = findMapping(character1)
            var character2 = findMapping(character2)
            
            if character1 < character2 { 
                hashMap[character2] = character1 
            } else {
                hashMap[character1] = character2
            }
        }
        
        let str1 = Array(s1)
        let str2 = Array(s2)
        for index in stride(from:0, to: s1.count, by:1) { 
            performUnion(str1[index], str2[index]) 
        }
        
        let baseCharacters = (Array(baseStr).map{ findMapping($0) })
        return baseCharacters.reduce(""){x, y in String(x) + String(y)}
    }
}