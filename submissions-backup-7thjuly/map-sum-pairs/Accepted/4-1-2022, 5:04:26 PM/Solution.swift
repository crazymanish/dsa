// https://leetcode.com/problems/map-sum-pairs

class MapSum {
    var hashMap: [String : Int] = [:]
    
    init() {}
    
    func insert(_ key: String, _ val: Int) {
        hashMap[key] = val
    }
    
    func sum(_ prefix: String) -> Int {
        var output = 0
        let hashMapKeys = Array(hashMap.keys)
        
        for hashMapKey in hashMapKeys {
            var currentKey = ""
            for char in hashMapKey {
                currentKey += String(char)
                
                if currentKey == prefix { 
                    output += hashMap[hashMapKey]!
                    break
                }
            }
        }
        
        return output
    }
}

/**
 * Your MapSum object will be instantiated and called as such:
 * let obj = MapSum()
 * obj.insert(key, val)
 * let ret_2: Int = obj.sum(prefix)
 */