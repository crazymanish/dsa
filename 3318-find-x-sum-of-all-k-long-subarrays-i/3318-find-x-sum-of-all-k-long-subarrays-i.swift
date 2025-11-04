// --- Complexity Analysis ---
//
// Let N = `n.count` (number of elements in the input array)
// Let K = `k` (the window size)
// Let U = Number of unique elements in a window (U <= K)
// Let X = `x` (the prefix size)
//
// Time Complexity: O(N * K log K)
//
// 1. `.windows(ofCount: k)`: This creates an iterator that will produce
//    O(N - K) windows. We can simplify this to O(N) windows.
// 2. `.map { window in ... }`: This closure runs O(N) times.
// 3. Inside the map closure (cost per window):
//    a. Create Frequency Map: This involves mapping O(K) elements and
//       building a dictionary. Total time is O(K).
//    b. Map to (freq, num) tuples: This iterates O(U) times. Time is O(U).
//    c. `.sorted(by: >)`: This sorts the (freq, num) tuples. This is
//       the dominant step. Time is O(U log U).
//       In the worst case, all K elements are unique (U = K), so this
//       step is O(K log K).
//    d. Map to products: Iterates O(U) times. Time is O(U).
//    e. `.prefix(x)`: Takes O(X) time.
//    f. `.reduce(0, +)`: Takes O(X) time.
//
// 4. Total Time = (Number of Windows) * (Cost per Window)
//    Total Time = O(N) * (O(K) + O(K log K))
//    Total Time = O(N * K log K)
//
// Space Complexity: O(N)
//
// 1. Output Array: The result of the final `.map` is an array of
//    size O(N - K), which is O(N) space.
// 2. Intermediate Storage (per window):
//    - `frequencyMap`: O(U) space.
//    - `freqNumTuples`: O(U) space.
//    - `sortedTuples`: O(U) space.
//    - `products`: O(U) space.
//    - `topXProducts`: O(X) space.
//    In the worst case (U=K), the temporary space per window is O(K).
//
// Total Space = O(Output) + O(Temporary) = O(N + K)
// Assuming N >= K, this simplifies to O(N).
class Solution {
    /**
     * For each sliding window of size `k` in `nums`, this function
     * calculates a special "x-sum".
     *
     * The "x-sum" is calculated as follows:
     * 1. Find the frequency of each number in the window.
     * 2. For each number, get its (frequency, number) pair.
     * 3. Sort these pairs: first by frequency (descending),
     * then by number (descending, as a secondary sort for tuples).
     * 4. For each pair, calculate the product (frequency * number).
     * 5. Take the top `x` of these products.
     * 6. Sum these top `x` products.
     *
     * - Parameter nums: The input array of numbers.
     * - Parameter k: The size of the sliding window.
     * - Parameter x: The number of top products to sum.
     * - Returns: An array of these "x-sum" values, one for each window.
     */
    func findXSum(_ nums: [Int], _ k: Int, _ x: Int) -> [Int] {
        
        // 1. Iterate over all sliding windows of size `k`.
        return nums.windows(ofCount: k).map { window -> Int in
            
            // 2. Create a frequency map for the current window.
            //    e.g., [1, 5, 1, 2] -> [1: 2, 5: 1, 2: 1]
            let frequencyMap = [Int: Int](
                window.map { ($0, 1) }, // [(1, 1), (5, 1), (1, 1), (2, 1)]
                uniquingKeysWith: +     // Combine keys with addition
            )
            
            // 3. Transform the map into (frequency, number) tuples
            //    to prepare for sorting.
            //    e.g., [1: 2, 5: 1, 2: 1] -> [(2, 1), (1, 5), (1, 2)]
            let freqNumTuples = frequencyMap.map { (number, frequency) in
                return (frequency, number)
            }
            
            // 4. Sort the tuples.
            //    Primary sort: by frequency (descending).
            //    Secondary sort (for ties): by number (descending).
            //    e.g., [(2, 1), (1, 5), (1, 2)] -> [(2, 1), (1, 5), (1, 2)]
            //    (In case of tie: [(1, 5), (1, 2)] sorts to [(1, 5), (1, 2)])
            let sortedTuples = freqNumTuples.sorted(by: >)
            
            // 5. Calculate the product (frequency * number) for each pair.
            //    (This fixes the compile error from the original `map(*)`)
            //    e.g., [(2, 1), (1, 5), (1, 2)] -> [2*1, 1*5, 1*2] -> [2, 5, 2]
            let products = sortedTuples.map { (frequency, number) in
                return frequency * number
            }
            
            // 6. Take the top `x` elements from this list of products.
            //    If x=2, [2, 5, 2] -> [2, 5]
            let topXProducts = products.prefix(x)
            
            // 7. Sum these `x` (or fewer) elements for the final "x-sum".
            //    e.g., 2 + 5 = 7
            let xSum = topXProducts.reduce(0, +)
            
            return xSum
        }
    }
}