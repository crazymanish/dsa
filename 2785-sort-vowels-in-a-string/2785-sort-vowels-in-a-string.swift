class Solution {
    func sortVowels(_ s: String) -> String {
        var sArray = Array(s)
        let vowels: Set<Character> = ["a", "A", "e", "E", "i", "I", "o", "O", "u", "U"]
        let indicesVowels = sArray.indices.filter { vowels.contains(sArray[$0]) }
        let sortedVowels = sArray.filter { vowels.contains($0) }.sorted()
        
        var currentIndexVowels = 0
        
        indicesVowels.forEach {
            sArray[$0] = sortedVowels[currentIndexVowels]
            currentIndexVowels += 1
        }
        
        return String(sArray)
    }
}