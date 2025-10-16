// Time Complexity: O(N + V)
// where N is the number of elements in `nums` and V is `value`.
// The first loop iterates through all N numbers to build the frequency map.
// The second `while` loop can run at most N+1 times, as it consumes one number
// from the original array in each iteration. Initializing the count array takes O(V).
//
// Space Complexity: O(V)
// We use an auxiliary array `count` of size `value` to store the frequencies
// of the remainders.
class Solution {
    func findSmallestInteger(_ nums: [Int], _ value: Int) -> Int {
        // `count` acts as a frequency map. `count[r]` will store how many numbers
        // in the input array have a remainder of `r` when divided by `value`.
        var count = [Int](repeating: 0, count: value)

        // Populate the frequency map.
        for num in nums {
            // This calculates a non-negative remainder, even for negative `num`.
            // e.g., for num = -1 and value = 5: ((-1 % 5) + 5) % 5 -> (-1 + 5) % 5 -> 4.
            let remainder = ((num % value) + value) % value 
            count[remainder] += 1
        }

        // `x` is the integer we are trying to "form" (0, 1, 2, ...). We are looking
        // for the smallest `x` that we *cannot* form.
        var x = 0
        while true {
            // To form the integer `x`, we need a number from `nums` that has the
            // same remainder as `x` when divided by `value`.
            let r = x % value
            
            // Check if we have any numbers with the required remainder `r`.
            if count[r] > 0 {
                // If yes, we can "form" `x`. We "use up" one of the numbers with
                // this remainder and try to form the next integer.
                count[r] -= 1
                x += 1
            } else {
                // If no, we cannot form `x`. This means `x` is the smallest
                // non-negative integer missing from our set, so it's the answer.
                return x
            }
        }
    }
}