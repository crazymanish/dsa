class Solution {
    func minSteps(_ s: String, _ t: String) -> Int {
        let hashMapS = hashMap(s)
        let hashMapT = hashMap(t)
        
        var output = 0
        for (key, valueS) in hashMapS {
            let valueT = hashMapT[key] ?? 0
            let minStepsRequired = max(valueS - valueT, 0)
            
            output += minStepsRequired
        }
        
        return output
    }

    private func hashMap(_ string: String) -> [Character : Int] {
        typealias Frequency = Int
        var hashMap: [Character : Frequency] = [:]

        for char in string {
            let hashMapValue = hashMap[char] ?? 0
            hashMap[char] = hashMapValue + 1
        }

        return hashMap
    }
}