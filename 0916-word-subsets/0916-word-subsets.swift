class Solution {
    func wordSubsets(_ A: [String], _ B: [String]) -> [String] {
        // Helper function to count character frequencies in a string
        func countFrequencies(_ word: String) -> [Character: Int] {
            var frequencyMap = [Character: Int]()
            for char in word {
                frequencyMap[char, default: 0] += 1
            }
            return frequencyMap
        }
    
        // Combine the frequency requirements from all strings in B
        var maxFrequencyMap = [Character: Int]()
        for b in B {
            let bFrequencyMap = countFrequencies(b)
            for (char, count) in bFrequencyMap {
                maxFrequencyMap[char] = max(maxFrequencyMap[char, default: 0], count)
            }
        }
    
        // Check each string in A to see if it meets the combined frequency requirements
        var result = [String]()
        for a in A {
            let aFrequencyMap = countFrequencies(a)
            var isUniversal = true
            for (char, count) in maxFrequencyMap {
                if aFrequencyMap[char, default: 0] < count {
                    isUniversal = false
                    break
                }
            }
            if isUniversal {
                result.append(a)
            }
        }
    
        return result
    }
}

/*
Explanation
Helper Function to Count Character Frequencies:
- The countFrequencies function takes a string and returns a dictionary with the frequency of each character in the string.

Combine Requirements from B:
- Create a dictionary maxFrequencyMap to store the maximum frequency of each character required by any string in B.
- Iterate through each string b in B, count its character frequencies, and update maxFrequencyMap to ensure it contains the maximum frequency of each character required by any string in B.

Check Each String in A:
- Iterate through each string a in A, count its character frequencies, and check if it meets the combined frequency requirements stored in maxFrequencyMap.
- For each character in maxFrequencyMap, ensure that a contains at least as many of that character as required. If any character requirement is not met, mark the string as not universal.

Collect Universal Strings:
- If a string a meets all the requirements, add it to the result list.
- Return the result list containing all universal strings from A.
*/