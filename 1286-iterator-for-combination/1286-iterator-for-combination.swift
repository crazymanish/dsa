
class CombinationIterator {
    private var allCombinations: [String] = []
    
    init(_ characters: String, _ combinationLength: Int) {
        let inputCharacters = Array(characters)
        let lastCharacterIndex = inputCharacters.count-1
        
        var currentCombination: [String] = []
        
        func findCombinations(_ currentIndex: Int) {
            if currentCombination.count == combinationLength {
                allCombinations.append(currentCombination.joined())
                return
            }

            if currentIndex > lastCharacterIndex { return }

            for index in currentIndex...lastCharacterIndex {
                let value = String(inputCharacters[index])
                
                currentCombination.append(value)

                findCombinations(index+1)

                currentCombination.removeLast() // backtracking
            }
        }
        
        findCombinations(0)
    }
    
    func next() -> String { allCombinations.removeFirst() }
    
    func hasNext() -> Bool { allCombinations.isEmpty == false }
}

/**
 * Your CombinationIterator object will be instantiated and called as such:
 * let obj = CombinationIterator(characters, combinationLength)
 * let ret_1: String = obj.next()
 * let ret_2: Bool = obj.hasNext()
 */
