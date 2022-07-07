// https://leetcode.com/problems/map-sum-pairs

class MapSum {
    var hashMap: [String : Int] = [:]
    
    init() {}
    
    func insert(_ key: String, _ val: Int) {
        let hashMapKey = find(key) ?? key
        var hashMapValue = hashMap[hashMapKey] ?? 0
        hashMapValue += val
        
        hashMap[hashMapKey] = hashMapValue
    }
    
    func sum(_ prefix: String) -> Int {
        if let hashMapKey = find(prefix) {
            return hashMap[hashMapKey]!
        }
        
        return 0
    }
    
    private func find(_ key: String) -> String? {
        if hashMap[key] != nil { return key }
        
        let hashMapKeys = Array(hashMap.keys)
        
        for hashMapKey in hashMapKeys {
            var prefix = ""
            for char in hashMapKey {
                prefix += String(char)
                
                if prefix == key { return hashMapKey }
            }
        }
        
        return nil
    }
}

/**
 * Your MapSum object will be instantiated and called as such:
 * let obj = MapSum()
 * obj.insert(key, val)
 * let ret_2: Int = obj.sum(prefix)
 */