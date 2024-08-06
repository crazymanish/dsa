class Solution {
    func minimumPushes(_ word: String) -> Int {
        // Step 1: Calculate the frequency of each character in the input word.
        var frequency: [Character: Int] = [:]
        for char in word {
            frequency[char, default: 0] += 1
        }
        
        // Step 2: Sort the frequencies in descending order.
        let sortedFrequencies = frequency.values.sorted(by: >)
        
        // Step 3: Distribute characters across the keys.
        // 8 keys available: keys 2 to 9.
        var totalPushes = 0
        var pressCount = 1
        var round = 0
        
        for freq in sortedFrequencies {
            totalPushes += freq * pressCount
            round += 1
            if round == 8 {
                round = 0
                pressCount += 1
            }
        }
        
        return totalPushes
    }
}