class Solution {
	func halvesAreAlike(_ s: String) -> Bool {
		let array = Array(s)
		let halfCount = array.count / 2
		let vowels: Set<Character> = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
        
        var firstHalfVowels = 0
        for i in 0..<halfCount where vowels.contains(array[i]) {
			firstHalfVowels += 1
		}
        
        var secondHalfVowels = 0
		for i in halfCount..<array.count where vowels.contains(array[i]) {
			secondHalfVowels += 1
		}
        
		return firstHalfVowels == secondHalfVowels
	}
}