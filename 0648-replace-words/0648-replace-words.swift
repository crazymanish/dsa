class Solution {
    func replaceWords(_ dictionary: [String], _ sentence: String) -> String {
        var hashMap: [String : Bool] = [:]
        for key in dictionary { hashMap[key] = true }
        
        var output = ""
        let words = sentence.components(separatedBy: " ")
        
        for word in words {
            var prefix = ""
            var isPrefixFound = false
            for char in word {
                prefix += String(char)
                if hashMap[prefix] != nil {
                    output += prefix
                    
                    isPrefixFound = true
                    break
                }
            }
            
            if isPrefixFound == false { output += prefix }
            output += " "
        }
        
        output.removeLast() // extra last space
        
        return output
    }
}