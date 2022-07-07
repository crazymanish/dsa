// https://leetcode.com/problems/truncate-sentence

class Solution {
    func truncateSentence(_ s: String, _ k: Int) -> String {
        let words = s.components(separatedBy: " ")
        
        var output = ""
        for index in 0..<k {
            if output.isEmpty == false { output += " " }
            
            output += words[index]
        }
        
        return output
    }
}