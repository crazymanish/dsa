// Time Complexity: O(N^2)
// The O(N log N) for sorting is dominated by the O(N^2) nested loop structure. The outer
// loop runs O(N) times, and the inner two-pointer scan also takes O(N), leading to O(N^2).
//
// Space Complexity: O(N)
// In Swift, `sorted()` creates a new array, requiring space proportional to the input size.
// If sorting were done in-place, space would be O(log N) to O(1) depending on the sort used.
class Solution {
    func triangleNumber(_ nums: [Int]) -> Int {
       // First, sort the array. If we ensure a <= b <= c, we only need to check if a + b > c.
       let numsSorted = nums.sorted()
       let n = numsSorted.count
       var count = 0

       // We iterate backwards, fixing the longest side 'c' of our potential triangle.
       // `numsSorted[k]` represents our side 'c'. The loop runs as long as there are at least
       // two elements before `k` to form a triplet.
       for k in stride(from: n-1, through: 2, by: -1) {
         // For each fixed 'c', use a two-pointer approach on the subarray numsSorted[0...k-1]
         // to find pairs (a, b) that satisfy a + b > c.
         var i = 0      // Left pointer for the smallest side 'a'.
         var j = k - 1  // Right pointer for the middle side 'b'.
         
         while i < j {
            // Check if the current triplet (numsSorted[i], numsSorted[j], numsSorted[k]) is valid.
            if numsSorted[i] + numsSorted[j] > numsSorted[k] {
                // ✅ Success! This pair (i, j) works.
                // Because the array is sorted, all elements between i and j, when paired with
                // numsSorted[j], will also form a valid triangle.
                // The number of such valid pairs is (j - 1) - i + 1 = j - i.
                count += j - i
                
                // We've counted all pairs for this 'j'. Now, try a smaller middle side 'b'
                // by moving the right pointer to the left.
                j -= 1
            } else {
                // The sum a + b is too small. To satisfy the inequality, we need a larger 'a'.
                // Move the left pointer to the right to increase the sum.
                i += 1
            }
         }
       }
       return count
    }
}