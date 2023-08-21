class Solution {
    func repeatedSubstringPattern(_ s: String) -> Bool {
        var newStr = s + s 
        
        newStr.removeFirst()
        newStr.removeLast()

        return newStr.contains(s)
    }
}