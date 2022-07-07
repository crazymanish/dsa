// https://leetcode.com/problems/largest-substring-between-two-equal-characters

class Solution {
    func maxLengthBetweenEqualCharacters(_ string: String) -> Int {
        var hashMap: [Character : Index] = [:]
        
        var index = 0
        for char in string {
            if var hashMapValue = hashMap[char] {
                hashMapValue.endIndex = index
            } else {
                hashMap[char] = Index(index, -1)
            }
            
            index += 1
        }
        
        var maxLengthIndex = Index(-1, -1)
        
        for (key, value) in hashMap {
            if value.endIndex > maxLengthIndex.endIndex {
                maxLengthIndex = value
            }
        }
        
        if maxLengthIndex.endIndex == -1 { return -1 }

        return maxLengthIndex.endIndex - maxLengthIndex.startIndex - 1
    }
}

private class Index {
    let startIndex: Int
    var endIndex: Int
    
    init(_ startIndex: Int, _ endIndex: Int) {
        self.startIndex = startIndex
        self.endIndex = endIndex
    }
}