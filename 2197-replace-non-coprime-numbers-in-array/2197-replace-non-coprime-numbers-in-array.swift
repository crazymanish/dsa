// Time Complexity: O(N * log K)
//   - N: The number of elements in the input array `nums`.
//   - K: The maximum value of a number in the `nums` array.
//   - The algorithm iterates through each of the N numbers once.
//   - For each number, it may enter a `while` loop that merges it with previous
//     elements. However, each number can be pushed onto the `result` stack once and
//     removed once. This leads to an amortized O(N) complexity for the push/pop logic.
//   - Inside the loop, we call the `gcd` function. The Euclidean algorithm's complexity
//     is logarithmic with respect to the smaller of its inputs, O(log K).
//   - Therefore, the total time complexity is O(N * log K).
//
// Space Complexity: O(N)
//   - In the worst-case scenario (if all numbers are coprime with their neighbors), the
//     `result` array will store all N numbers. Thus, the space required is
//     proportional to the input size.
class Solution {
    /**
     * Replaces adjacent non-coprime numbers in an array with their LCM until no such pairs exist.
     *
     * The problem requires us to repeatedly find the *leftmost* adjacent non-coprime pair
     * and replace it with its LCM. A naive approach of scanning and modifying the array would be
     * inefficient (O(N²)).
     *
     * A more efficient strategy is to use a stack-like approach. We build a `result` array
     * by processing one number at a time from the input. When we add a new number, we
     * check if it's non-coprime with the last number already in `result`. If it is, we
     * merge them (by replacing them with their LCM) and repeat the check with the new
     * merged number and the element now at the end of `result`. This continues until the
     * end of the `result` array is stable (i.e., the last two elements are coprime).
     *
     * - Parameter nums: An array of integers.
     * - Returns: The final array after all non-coprime merges are complete.
     */
    func replaceNonCoprimes(_ nums: [Int]) -> [Int] {
        var result = [Int]()
        
        // Process each number from the input array.
        for num in nums {
            result.append(num)
            
            // The "merge" loop: as long as the stack has at least two numbers,
            // check if the last two can be merged.
            while result.count > 1 {
                let lastNum = result[result.count - 1]
                let secondToLastNum = result[result.count - 2]
                
                let commonDivisor = gcd(lastNum, secondToLastNum)
                
                // If the GCD is greater than 1, the numbers are not coprime.
                if commonDivisor > 1 {
                    // Pop the two numbers and push their LCM.
                    result.removeLast()
                    result.removeLast()
                    
                    // LCM(a, b) = (|a * b|) / GCD(a, b).
                    // We calculate as (a / GCD) * b to prevent potential integer overflow from a * b.
                    let leastCommonMultiple = (lastNum / commonDivisor) * secondToLastNum
                    result.append(leastCommonMultiple)
                } else {
                    // If they are coprime, the merging process for this `num` is done.
                    break
                }
            }
        }
        return result
    }

    /**
     * Calculates the Greatest Common Divisor (GCD) of two integers using the Euclidean algorithm.
     */
    private func gcd(_ a: Int, _ b: Int) -> Int {
        var num1 = a
        var num2 = b
        while num2 != 0 {
            let temp = num2
            num2 = num1 % num2
            num1 = temp
        }
        return num1
    }
}