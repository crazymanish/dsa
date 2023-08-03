class Solution {
    func letterCombinations(_ digits: String) -> [String] {
        if digits.count == 0 { return [] }
        
        let lettersHashMap: [Character: [Character]] = [
	        "2": ["a","b","c"],
	        "3": ["d","e","f"],
	        "4": ["g","h","i"],
	        "5": ["j","k","l"],
	        "6": ["m","n","o"],
	        "7": ["p","q","r", "s"],
	        "8": ["t","u","v"],
	        "9": ["w","x","y", "z"]
        ]
        
        let digitCharacters = Array(digits)
        let combinationLength = digits.count
        let lastDigitIndex = digits.count-1
        
        var allCombinations: [String] = []
        var currentCombination: [String] = []
        
        func findCombinations(_ currentIndex: Int) {
            if currentCombination.count == combinationLength {
                allCombinations.append(currentCombination.joined())
                return
            }

            if currentIndex > lastDigitIndex { return }

            for index in currentIndex...lastDigitIndex {
                let digit = digitCharacters[index]
                let letters = lettersHashMap[digit] ?? []
                
                for character in letters {
                    let value = String(character)
                    
                    currentCombination.append(value)
                    findCombinations(index+1)
                    currentCombination.removeLast() // backtracking
                }
            }
        }
        
        findCombinations(0)
        return allCombinations
    }
}