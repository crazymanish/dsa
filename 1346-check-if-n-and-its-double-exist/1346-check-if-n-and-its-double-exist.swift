class Solution {
    func checkIfExist(_ array: [Int]) -> Bool {
        var hashMap: [Int : Bool] = [:]
        
        for element in array {
            if hashMap[(element * 2)] != nil || 
            (element % 2 == 0 && hashMap[(element / 2)] != nil) { 
                return true 
            } else {
                hashMap[element] = true
            }
        }
        
        return false
    }
}