class Solution {
    func canMakeSubsequence(_ s: String, _ t: String) -> Bool {
        var tIndex = 0
        let tChars = Array(t)
        let sChars = Array(s)
        
        func canIncrement(_ sChar: Character, to tChar: Character) -> Bool {
            if sChar == tChar { return true }
            
            if sChar == "z" && tChar == "a" { return true }
            
            return sChar.asciiValue! + 1 == tChar.asciiValue!
        }
    
        for sChar in sChars {
            if tIndex < tChars.count && canIncrement(sChar, to: tChars[tIndex]) {
                tIndex += 1
            }
        }
    
        return tIndex == tChars.count
    }
}

/*
Explanation
Initialize Variables:
- tIndex: An index to keep track of the current position in the string t.
- tChars: An array of characters from the string t.
- sChars: An array of characters from the string s.

Iterate Through the String s:
- Loop through each character in the sChars array.
- Check if the current character in s can be incremented to match the current character in t using the canIncrement function.
- If it can, increment the tIndex.

Check for Cyclic Increment:
- The canIncrement function checks if a character in s can be incremented to match a character in t.
- It returns true if the characters are the same, if sChar is 'z' and tChar is 'a', or if the ASCII value of sChar plus one equals the ASCII value of tChar.

Return the Result:
- If all characters in t can be matched, the function returns true.
- If not, the function returns false.

This approach ensures that the function efficiently checks if t can be made a subsequence of s using cyclic increments.
*/