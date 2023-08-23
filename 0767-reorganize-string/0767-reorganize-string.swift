class Solution {
    func reorganizeString(_ s: String) -> String {
        let frequencyHashMap = s.reduce(into: [:]) {$0[$1, default: 0] += 1}
        var maxHeap = MaxHeap<CharacterModel>(>)
        frequencyHashMap.forEach { maxHeap.push(CharacterModel(String($0.0), $0.1)) }
        var reorganizedString = ""

        while !maxHeap.isEmpty {
            var currentCharacterModel = maxHeap.pop()! // 100% not nil
            var nextCharacterModel = maxHeap.pop()  // may be nil
            
            // if there is no next letter and more than 1 left:
            if nextCharacterModel == nil && currentCharacterModel.frequencyCount > 1 { return "" } 
            
            reorganizedString.append(currentCharacterModel.value)
            reorganizedString.append(nextCharacterModel?.value ?? "")
            currentCharacterModel.frequencyCount -= 1
            nextCharacterModel?.frequencyCount -= 1
            
            if currentCharacterModel.frequencyCount != 0 {
                maxHeap.push(currentCharacterModel)
            }
            
            if nextCharacterModel != nil && nextCharacterModel!.frequencyCount != 0 {
                maxHeap.push(nextCharacterModel!)
            }
        }
        
        return reorganizedString
    }
}

struct CharacterModel: Comparable {
    let value: String
    var frequencyCount: Int
    
    init(_ value: String, _ frequencyCount: Int) {
        self.value = value
        self.frequencyCount = frequencyCount
    }
    
    static func < (lhs: CharacterModel, rhs: CharacterModel) -> Bool {
        return lhs.frequencyCount < rhs.frequencyCount
    }
}

struct MaxHeap<T: Comparable> {
    private var heap = [T]()
    private let comparator: (T, T) -> Bool 
    
    init(_ comparator: @escaping (T, T) -> Bool) {
        self.comparator = comparator
    }
    
    var isEmpty: Bool {heap.isEmpty}
    
    mutating func push(_ newValue: T) {
        heap.append(newValue)
        
        var currentIndex = heap.count-1
        while currentIndex > 0 && comparator(heap[currentIndex], heap[(currentIndex-1)/2]) {
            heap.swapAt(currentIndex, (currentIndex-1)/2)
            currentIndex = (currentIndex-1)/2
        }
    }
    
    mutating func pop() -> T? {
        guard let poppedItem = heap.first else { return nil }
        
        heap[0] = heap.last!
        var currentIndex = 0
        while currentIndex*2 + 2 < heap.count {
            let swapIndex = comparator(heap[currentIndex*2 + 1], heap[currentIndex*2 + 2]) ? (currentIndex*2 + 1) : (currentIndex*2 + 2)
            if comparator(heap[swapIndex], heap[currentIndex]) {
                heap.swapAt(currentIndex, swapIndex)
                currentIndex = swapIndex
            } else {
                break
            }
        }
        heap.popLast()
        
        return poppedItem
    }
}