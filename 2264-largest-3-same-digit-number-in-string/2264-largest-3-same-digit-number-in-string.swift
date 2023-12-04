class Solution {
    func largestGoodInteger(_ num: String) -> String {
        var answer: Character = "-"
        var repeats = 1
        var current = num[num.startIndex]
        for next in num.dropFirst() {
            repeats = current == next ? repeats + 1 : 1
            current = next
            if repeats == 3 {
                answer = max(answer, current)
            }
        }
        return answer == "-" ? "" : String(repeating: answer, count: 3)
    }
}