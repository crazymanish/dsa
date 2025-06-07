// Time Complexity: O(N)
// The algorithm iterates through the input string of length N twice.
// - The first loop processes each character. Operations inside the loop, such as
//   inserting into a set or manipulating the priority queue and index map, take
//   effectively constant time. This is because the priority queue and index map
//   only deal with a maximum of 26 unique characters (a constant, K).
//   - The provided Priority Queue's `push` operation (with sorting) is O(K log K). Since K <= 26, this is O(1).
//   - The `pop` operation is O(K), which is also O(1).
// - The second loop builds the final string, which also takes O(N) time.
// Therefore, the total time complexity is dominated by the linear scans of the string.
//
// Space Complexity: O(N)
// - `charIndices`: In the worst-case scenario (a string with no '*' characters),
//   this map will store the indices of all N characters.
// - `indicesToRemove`: This set can store up to N indices in the worst case
//   (e.g., a string of N/2 characters followed by N/2 stars).
// - The `result` string can also have a length up to N.
// The space required is therefore proportional to the length of the input string.

class Solution {
    func clearStars(_ s: String) -> String {
        // A min-priority queue to keep track of the lexicographically smallest characters encountered so far.
        var charPriorityQueue = PriorityQueue<Character>()
        
        // Maps each character ('a'...'z') to a list of its indices in the string.
        // Index 0 corresponds to 'a', 1 to 'b', and so on.
        var charIndices = Array(repeating: [Int](), count: 26)
        
        // A set to store the indices of characters and stars that should be removed.
        var indicesToRemove = Set<Int>()
        
        // First pass: Iterate through the string to identify which elements to remove.
        for (currentIndex, char) in s.enumerated() {
            if char == "*" {
                // Mark the star itself for removal.
                indicesToRemove.insert(currentIndex)
                
                // Find the smallest character seen so far that is available for removal.
                if let smallestChar = charPriorityQueue.peek() {
                    // Calculate the corresponding index for the character ('a' -> 0, 'b' -> 1, ...).
                    let charCode = Int(smallestChar.asciiValue! - Character("a").asciiValue!)
                    
                    // Get the rightmost (i.e., most recent) index of this smallest character.
                    if let indexToRemove = charIndices[charCode].last {
                        // Mark this character's index for removal.
                        indicesToRemove.insert(indexToRemove)
                        
                        // This index is now used, so remove it from our tracking list.
                        charIndices[charCode].removeLast()
                        
                        // If no more occurrences of this character are left, remove it from the priority queue.
                        if charIndices[charCode].isEmpty {
                            charPriorityQueue.pop()
                        }
                    }
                }
            } else { // The character is a letter.
                // Calculate the mapping index for the character.
                let charCode = Int(char.asciiValue! - Character("a").asciiValue!)
                
                // If this is the first recorded occurrence of this character, add it to the priority queue.
                if charIndices[charCode].isEmpty {
                    charPriorityQueue.push(char)
                }
                
                // Record the current index for this character.
                charIndices[charCode].append(currentIndex)
            }
        }
        
        // Second pass: Build the result string, skipping the characters and stars marked for removal.
        var result = ""
        for (index, char) in s.enumerated() {
            // Append the character if its index is not in the removal set.
            if !indicesToRemove.contains(index) {
                result.append(char)
            }
        }
        
        return result
    }
}

// A simple Priority Queue implementation using a sorted array.
// Note: This implementation is straightforward but has performance implications for general use.
// The `push` operation's complexity is O(K log K) due to sorting, where K is the number of elements.
// For the `clearStars` function, K is at most 26 (the alphabet size), making the operations
// perform in effectively constant time. A more efficient, general-purpose priority queue
// would typically be implemented with a heap data structure.
struct PriorityQueue<T: Comparable> {
    // The underlying array to store the queue's elements.
    private var elements: [T] = []
    
    /// A Boolean value indicating whether the priority queue is empty.
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    /// Returns the smallest element in the queue without removing it (O(1) complexity).
    func peek() -> T? {
        return elements.first
    }
    
    /// Adds a new element to the queue and maintains the sorted order.
    mutating func push(_ value: T) {
        elements.append(value)
        // Re-sorts the entire array on each push to maintain order.
        elements.sort(by: <)
    }
    
    /// Removes and returns the smallest element from the queue (O(K) complexity for an array).
    mutating func pop() -> T? {
        if isEmpty {
            return nil
        }
        return elements.removeFirst()
    }
}