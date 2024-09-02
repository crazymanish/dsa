class Solution {
    func chalkReplacer(_ chalk: [Int], _ k: Int) -> Int {
        // Step 1: Calculate the total chalk usage in one round
        let totalChalk = chalk.reduce(0, +)
        
        // Step 2: Reduce k by the total chalk usage modulo
        var remainingChalk = k % totalChalk
        
        // Step 3: Find the student who will run out of chalk
        for (index, chalkNeeded) in chalk.enumerated() {
            if remainingChalk < chalkNeeded {
                return index
            }
            remainingChalk -= chalkNeeded
        }
        
        // This line should never be reached if the input is correct
        return -1
    }
}