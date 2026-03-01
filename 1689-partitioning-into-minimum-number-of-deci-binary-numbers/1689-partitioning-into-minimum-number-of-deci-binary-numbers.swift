class Solution {

    /**
     ------------------------------------------------------------------------
     Problem Summary:
        Given a decimal string `n`, return the minimum number of deci-binary
        numbers needed to sum up to `n`.

        A deci-binary number contains only digits 0 or 1.

     Strategy:
        - Each deci-binary number can contribute at most 1 to each digit place.
        - Therefore, to build a digit `d`, we need at least `d` deci-binary numbers.
        - The answer is simply the maximum digit in the string.

        So we iterate through the string and track the maximum digit.

     Time Complexity:
        O(n)
        We scan the string once.

     Space Complexity:
        O(1)
        We only store a single integer (maximum digit).
     ------------------------------------------------------------------------
     */
    
    func minPartitions(_ n: String) -> Int {
        var maximumDigit = 0
        
        // Iterate through each character (digit) in the string
        for character in n {
            // Convert character to integer digit
            if let digit = character.wholeNumberValue {
                // Update maximum digit found so far
                maximumDigit = max(maximumDigit, digit)
                
                // Early exit optimization:
                // If we reach 9, we cannot do better since digits are 0–9.
                if maximumDigit == 9 {
                    return 9
                }
            }
        }
        
        return maximumDigit
    }
}