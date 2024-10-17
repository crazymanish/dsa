class Solution {
    func maximumSwap(_ num: Int) -> Int {
        if num <= 11 { return num }

        // Digits of a number, in order from right to left
        var digits: [Int] = [num % 10]
        var n = num / 10
        var currentIndex = 1, digit: Int

        // Index of max digit so far
        var maxDigitIndex = 0
        // Potential swap indexes
        var swapIdx1 = -1, swapIdx2 = -1

        while n != 0 {
            digit = n % 10
            digits.append(digit)

            if digit > digits[maxDigitIndex] {
                maxDigitIndex = currentIndex  // Update the index of the max digit
            } else if digit < digits[maxDigitIndex] {
                swapIdx1 = currentIndex   // Mark the smaller digit for swapping
                swapIdx2 = maxDigitIndex  // Mark the larger digit for swapping
            }
            
            n /= 10
            currentIndex += 1
        }
        
        // Check if a valid swap is found
        if swapIdx1 != -1 {
            // Perform the swap
            digits.swapAt(swapIdx1, swapIdx2)
            // Reconstruct the number from digits
            return digits.reversed().reduce(0) { $0*10 + $1 }
        } else { // Return the original number
            return num
        }
    }
}