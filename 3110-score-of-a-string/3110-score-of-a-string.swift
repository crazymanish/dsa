class Solution {
    func scoreOfString(_ s: String) -> Int {
        guard var previous = s.first else { return 0 }
        
        var answer = 0
        for index in s.indices.dropFirst() {
            let char = s[index]
            answer += abs(Int(char.asciiValue ?? 0) - Int(previous.asciiValue ?? 0))
            previous = char
        }
        
        return answer
    }
}