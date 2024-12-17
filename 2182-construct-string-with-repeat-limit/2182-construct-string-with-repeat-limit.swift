import Collections

struct HeapItem: Comparable {
    var character: Character 
    var count: Int
    
    init(_ character: Character, _ count: Int) {
        self.character = character
        self.count = count
    }
    
    static func <(lhs: Self, rhs: Self) -> Bool { lhs.character < rhs.character }
}

class Solution {
    func repeatLimitedString(_ s: String, _ repeatLimit: Int) -> String {
        let freq = Dictionary(zip(s,repeatElement(1,count:s.count)), uniquingKeysWith: +)
        var heap = Heap(freq.map(HeapItem.init))
        var result = ""
        
        while var item = heap.popMax() {
            while true {
                result += String(repeating: item.character, count: min(item.count, repeatLimit))
                item.count -= repeatLimit
                
                guard item.count > 0, let next = heap.popMax() else { break }
                result.append(next.character) // poke one char from next largest character
                
                if next.count > 1 {
                    heap.insert(HeapItem(next.character, next.count-1))
                }
            }
        }
        
        return result
    }
}