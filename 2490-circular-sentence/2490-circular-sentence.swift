class Solution {
    func isCircularSentence(_ s: String) -> Bool {
        guard s.first == s.last else { return false }
        
        let sArray = Array(s)
        
        for i in sArray.indices where sArray[i] == " " {
            guard sArray[i-1] == sArray[i+1] else { return false }
        }
        
        return true
    }
}