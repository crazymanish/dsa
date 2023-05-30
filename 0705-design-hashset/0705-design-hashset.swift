
class MyHashSet {
    private var cache: [Bool]
    
    init() {
        cache = Array(repeating: false, count: 1000001)
    }
    
    func add(_ key: Int) {
        cache[key] = true
    }
    
    func remove(_ key: Int) {
        cache[key] = false
    }
    
    func contains(_ key: Int) -> Bool {
        cache[key]
    }
}

/**
 * Your MyHashSet object will be instantiated and called as such:
 * let obj = MyHashSet()
 * obj.add(key)
 * obj.remove(key)
 * let ret_3: Bool = obj.contains(key)
 */