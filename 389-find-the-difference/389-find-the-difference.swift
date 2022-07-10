class Solution {
    func findTheDifference(_ s: String, _ t: String) -> Character {
        let hashMapS = hashMap(s)
        let hashMapT = hashMap(t)
        
        var outputChar: Character = "0"
        
        for (key, value) in hashMapT {
            if let valueS = hashMapS[key] {
                if valueS != value {
                    outputChar = key
                    break
                }
            } else {
                outputChar = key
                break
            }
        }
        
        return outputChar
    }
    
    private func hashMap(_ text: String) -> [Character : Int] {
        var hashMap: [Character : Int] = [:]
        
        for char in text {
            let hashMapValue = hashMap[char] ?? 0
            hashMap[char] = hashMapValue + 1
        }
        
        return hashMap
    }
}