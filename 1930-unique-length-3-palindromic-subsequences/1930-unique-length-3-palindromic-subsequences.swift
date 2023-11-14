class Solution {
    func countPalindromicSubsequence(_ s: String) -> Int {
        let sArray = Array(s)

        var first: [Character: Int] = [:]
        var last: [Character: Int] = [:]
        for (index, char) in sArray.enumerated() {
            first[char] = first[char] ?? index
            last[char] = index
        }

        var answers: Int = 0
        for (index, left) in first {
            if let right = last[index], right != left {
                let mids = Set(sArray[(left+1)..<right])
                answers += mids.count
            }
        }

        return answers
    }
}