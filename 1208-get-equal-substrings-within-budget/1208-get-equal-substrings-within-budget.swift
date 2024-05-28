class Solution {
    func equalSubstring(_ s: String, _ t: String, _ maxCost: Int) -> Int {
        let sChars = Array(s.unicodeScalars)
        let tChars = Array(t.unicodeScalars)
        
        var left = 0
        var right = 0
        var result = 0
        var current = 0
        while right < sChars.count {
            let sCharValue = Int(Character(sChars[right]).asciiValue ?? 0)
            let tCharValue = Int(Character(tChars[right]).asciiValue ?? 0)
            current += abs(sCharValue - tCharValue)

            while current > maxCost {
                let sCharValue = Int(Character(sChars[left]).asciiValue ?? 0)
                let tCharValue = Int(Character(tChars[left]).asciiValue ?? 0)
                current -= abs(sCharValue - tCharValue)
                left += 1
            }

            result = max(result, right - left + 1)
            right += 1
        }

        return result
    }
}