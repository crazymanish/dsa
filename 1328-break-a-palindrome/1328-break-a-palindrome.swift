class Solution {
    func breakPalindrome(_ palindrome: String) -> String {
		// If palindrome has only one letter we can't break it by changing one letter
        guard palindrome.count > 1 else { return "" }
        
        var palindromeArray = Array(palindrome)
        let a = Character("a")
        let b = Character("b")
        
        for i in 0..<palindromeArray.count {
			// Looking for first non-a character
            if palindromeArray[i] != a {
                
				// Propecting ourselfs from cases like "aabaa"
				// Becase in this scenario we can get palindrome "aaaaa" as a result of replacement
                if palindromeArray.count % 2 == 1, i == palindromeArray.count / 2 {
                    break
                } 
                
                palindromeArray[i] = a
                return String(palindromeArray)
            }
        }
        
		// If all letters are "a" or we have palindrome like "aabaa"
		// We need to change last letter to "b"
        palindromeArray[palindromeArray.count - 1] = b
        return String(palindromeArray)
    }
    
}