class Solution {
    func maxUniqueSplit(_ s: String) -> Int {
        var result = Int.min
        var temp = [String]()
        var set = Set<String>()
        var n = s.count
        
        func backTracking(_ index: Int) {
            if index == n {
             result = max(result, temp.count)
                return
            }

            var string = String()

            for i in index..<n {
                string.append(s[i])

                if !set.contains(string) {
                    set.insert(string)
                    temp.append(string)

                    backTracking(i+1)

                    set.remove(string)
                    temp.removeLast()
                }
            }
        }
        
        backTracking(0)
        return result
    }
}

extension String {
    subscript (_ at: Int) -> Self {
        return String( self[index(startIndex, offsetBy: at)] )
    }
}