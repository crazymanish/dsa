class Solution {
    func shiftingLetters(_ s: String, _ shifts: [[Int]]) -> String {
        // Initialize an array to keep track of the net shifts for each character
        var shift = [Int](repeating: 0, count: s.count + 1)
        let n = s.count
        let sArray = Array(s)
    
        // Apply shifts using a difference array
        for shiftInfo in shifts {
            let start = shiftInfo[0]
            let end = shiftInfo[1]
            let direction = shiftInfo[2]
        
            // If direction is 1, shift to the right
            if direction == 1 {
                shift[start] += 1
                if end + 1 < n {
                    shift[end + 1] -= 1
                }
            } else { // If direction is 0, shift to the left
                shift[start] -= 1
                if end + 1 < n {
                    shift[end + 1] += 1
                }
            }
        }
    
        // Calculate the net shifts
        var netShift = 0
        for i in 0..<n {
            netShift += shift[i]
            shift[i] = netShift
        }

        func shiftCharacter(_ char: Character, _ shift: Int) -> Character {
            // Calculate the ASCII values for 'a' and 'z'
            let aAscii = Int(Character("a").asciiValue!)
            let zAscii = Int(Character("z").asciiValue!)
            let charAscii = Int(char.asciiValue!)
    
            // Calculate the new ASCII value after applying the shift
            let newAscii = (charAscii - aAscii + shift) % 26
            let finalAscii = (newAscii + 26) % 26 + aAscii
    
            // Return the new character
            return Character(UnicodeScalar(finalAscii)!)
        }
    
        // Apply the net shifts to the string
        var result = ""
        for i in 0..<n {
            let newChar = shiftCharacter(sArray[i], shift[i])
            result.append(newChar)
        }
    
        return result
    }
}