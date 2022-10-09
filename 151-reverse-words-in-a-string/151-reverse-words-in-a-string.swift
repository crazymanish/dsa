class Solution {
    func reverseWords(_ s: String) -> String {
        var words = s.components(separatedBy: " ")
        words = words.filter { !$0.isEmpty }
        
        let wordsCount = words.count
        var currentIndex = 0
        var reverseString = ""
        
        for word in words.reversed() {
            reverseString += word
            
            if currentIndex != wordsCount-1 {
                reverseString += " "
            }
            
            currentIndex += 1
        }
        
        return reverseString
    }
}