class Solution {
    func numberOfAlternatingGroups(_ colors: [Int], _ k: Int) -> Int {
        var start = 0 // Start index of the current window
        var end = 0   // End index of the current window
        var result = 0 // Count of alternating groups of size k

        for i in 0..<colors.count {
            start = i // Set the start of the window to the current index
            if end <= start {
                end = start + 1 // Ensure the end is at least one position ahead of the start
            }

            // Expand the window as long as it meets the alternating condition and size requirement
            while (end - start) + 1 <= k {
                // Check if the adjacent colors are the same, breaking the alternating pattern
                if colors[(end - 1) % colors.count] == colors[end % colors.count] {
                    break // Exit the loop if the pattern is broken
                }

                // Check if the window has reached the desired size k
                if (end - start) + 1 == k {
                    result += 1 // Increment the result if a valid group of size k is found
                    break // Exit the loop after finding a valid group
                }

                end += 1 // Expand the window by moving the end index forward
            }
        }

        return result // Return the total count of alternating groups
    }
}