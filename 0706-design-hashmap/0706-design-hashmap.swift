class MyHashMap {
    private(set) var hashMap: [Int:Int]!

    init() {
        self.hashMap = [:]
    }

    func put(_ k: Int, _ v: Int) {
        hashMap[k] = v
    }

    func get(_ k: Int) -> Int {
        return hashMap[k] ?? -1
    }

    func remove(_ k: Int) {
        hashMap[k] = nil
    }
}
/**
 * Your MyHashMap object will be instantiated and called as such:
 * let obj = MyHashMap()
 * obj.put(key, value)
 * let ret_2: Int = obj.get(key)
 * obj.remove(key)
 */