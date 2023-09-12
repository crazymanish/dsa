class Solution {
    func minDeletions(_ s: String) -> Int {
        guard s.count > 0 else { return 0 }
        
        var count: Int = 0
        
        var hashMap: [Character: Int] = [:]
        s.forEach { hashMap[$0, default: 0] += 1 }
        
        var set: Set<Int> = []
        hashMap.forEach {
            guard var value = hashMap[$0.key] else { return }
            
            while set.contains(value) {
                value -= 1
                count += 1
            }
            
            if value > 0 { set.insert(value) }
        }
        
        return count
    }
}