// Time Complexity: O(P log P + S log P)
// where S is the number of spells and P is the number of potions.
// The initial sorting of the potions array takes O(P log P). Then, for each of the S
// spells, we perform a binary search on the potions array, which takes O(log P).
//
// Space Complexity: O(P + S)
// In Swift, `sorted()` creates a new array, requiring O(P) space. The result array
// `successfulPairs` also requires O(S) space.
class Solution {
    func successfulPairs(_ spells: [Int], _ potions: [Int], _ success: Int) -> [Int] {
        var successfulPairs = [Int]()
        
        // Sorting the potions array is the key. It allows us to use an efficient
        // binary search for each spell, avoiding a slow O(S*P) brute-force check.
        let potions = potions.sorted()

        // This nested function performs a binary search for a given spell.
        // Its goal is to find the index of the *first* potion that forms a successful pair.
        func binarySearch(_ spell: Int) {
            var left = 0
            var right = potions.count - 1
        
            // The binary search loop will find the "insertion point" or "lower bound"
            // for the minimum required potion strength.
            while left <= right {
                // Using `(left + right) / 2` is fine here, but `left + (right - left) / 2`
                // is safer to prevent potential overflow in languages with fixed-size integers.
                let middle = (left + right) / 2
            
                // Check if the potion at `middle` is strong enough.
                if potions[middle] * spell >= success {
                    // This potion works, but there might be an even weaker (earlier)
                    // potion that also works. So, we continue searching in the left half.
                    right = middle - 1
                } else {
                    // This potion is too weak. We need a stronger one, so we must
                    // search in the right half of the array.
                    left = middle + 1
                }
            }
            
            // After the loop, `left` points to the index of the first potion that is
            // strong enough. All potions from this index to the end of the array will
            // also form successful pairs.
            // The number of successful pairs is therefore the total count minus this index.
            successfulPairs.append(potions.count - left)
        }

        // Iterate through each spell and run the binary search to find its count of successful pairs.
        for spell in spells {
            binarySearch(spell)
        }
        
        return successfulPairs
    }
}