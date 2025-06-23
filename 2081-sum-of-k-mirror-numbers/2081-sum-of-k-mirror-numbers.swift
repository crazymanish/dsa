// Time Complexity: Difficult to analyze precisely. It is roughly proportional to
// `n * log_k(N) * log10(N)`, where `N` is the value of the largest k-mirror number found.
// The algorithm efficiently generates every base-10 palindrome in increasing order and,
// for each, performs a check in base `k`. The check's cost is proportional to the number of digits.

// Space Complexity: O(log_k(N))
// The space is dominated by the array used to store the digits of a number in base `k`
// during the palindrome check.
class Solution {
    /**
     * Calculates the sum of the first `n` k-mirror numbers.
     * A k-mirror number is a number that is a palindrome in both base 10 and base `k`.
     *
     * - Parameters:
     * - k: The base to check for the mirror property.
     * - n: The target count of k-mirror numbers to find.
     * - Returns: The sum of the first `n` k-mirror numbers.
     */
    func kMirror(_ k: Int, _ n: Int) -> Int {
        
        /// Checks if a number is a palindrome when represented in base `k`.
        func isPalindromeInBaseK(_ number: Int) -> Bool {
            var digits: [Int] = []
            var currentNumber = number
            
            if currentNumber == 0 { return true }
            
            while currentNumber > 0 {
                digits.append(currentNumber % k)
                currentNumber /= k
            }
            // A number is a palindrome if its digit sequence is the same forwards and backwards.
            return digits == digits.reversed()
        }

        var kMirrorNumbersFound = 0
        var totalSum: Int = 0
        var halfNumberStart = 1
        
        // We generate decimal palindromes by building them from their "left half".
        // For example, from `123`, we generate `12321` (odd length) and `123321` (even length).
        // We iterate through lengths of the left half (1-digit halves, 2-digit halves, etc.).
        while kMirrorNumbersFound < n {
            let halfNumberEnd = halfNumberStart * 10
            
            // Generate both odd and even-length palindromes for the current range of halves.
            for isOddLength in [true, false] {
                
                // Iterate through all possible "left half" numbers in the current range.
                for half in halfNumberStart..<halfNumberEnd {
                    if kMirrorNumbersFound == n { break }

                    var palindrome = half
                    
                    // Determine the part of the half to mirror as the suffix.
                    // For odd-length (e.g., half=123 -> 12321), the suffix comes from `12`.
                    // For even-length (e.g., half=123 -> 123321), the suffix comes from `123`.
                    var suffixSource = isOddLength ? half / 10 : half
                    
                    // Append the mirrored digits to form the full palindrome.
                    while suffixSource > 0 {
                        palindrome = palindrome * 10 + (suffixSource % 10)
                        suffixSource /= 10
                    }
                    
                    if isPalindromeInBaseK(palindrome) {
                        kMirrorNumbersFound += 1
                        totalSum += palindrome
                    }
                }
                if kMirrorNumbersFound == n { break }
            }
            
            // Move to the next range for the left half (e.g., from 1-9 to 10-99).
            halfNumberStart = halfNumberEnd
        }

        return totalSum
    }
}