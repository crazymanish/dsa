class Solution {
    func largestOddNumber(_ num: String) -> String {
        let oddDigits: Set<Character> = ["1", "3", "5", "7", "9"]
        
        if let lastOddIndex = num.lastIndex { oddDigits.contains($0) } {
            return String(num[num.startIndex...lastOddIndex])
        } else { 
            return "" 
        }
    }
}