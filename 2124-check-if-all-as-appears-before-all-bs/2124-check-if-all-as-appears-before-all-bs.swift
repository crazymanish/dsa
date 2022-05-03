class Solution {
    func checkString(_ s: String) -> Bool {
        let sArray = Array(s)
        
        var index = 1
        while index < sArray.count {
            if sArray[index-1] == "b" && sArray[index] == "a" { return false }
            
            index += 1
        }
        
        return true
    }
}