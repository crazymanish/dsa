class Solution {
    func minJumps(_ arr: [Int]) -> Int {
        var indexDict = [Int: [Int]]()
        for (index, element) in arr.enumerated() {
            indexDict[element, default: []].append(index)
        }

        var queue = [(index: Int, steps: Int)]()
        queue.append((index: 0, steps: 0))
        
        var visited = Set<Int>()
        visited.insert(0)

        while !queue.isEmpty {
            var tempQueue = queue
            queue.removeAll()

            for element in tempQueue {
                if element.index == arr.count - 1 {
                    return element.steps
                }
                
                let currentIndex = element.index
                var nextIndexes: [Int] = []
                nextIndexes += currentIndex + 1 < arr.count ? [currentIndex + 1] : []
                nextIndexes += currentIndex - 1 >= 0 ? [currentIndex - 1] : []
                nextIndexes += indexDict[arr[currentIndex], default: []]
                
                // removing used indexes, so that its not added again (otherwise arr will become massive).
                indexDict[arr[currentIndex]] = nil
                for index in nextIndexes where !visited.contains(index) && (index < arr.count && index >= 0) {
                   queue.append((index: index, steps: element.steps + 1))
                   visited.insert(index)
                }
            }
        }
        
        return -1
    }
}