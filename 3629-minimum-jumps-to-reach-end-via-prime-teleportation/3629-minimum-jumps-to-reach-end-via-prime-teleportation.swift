/**
 Problem Summary:
 Given an array `nums`, you start at index 0 and want to reach index n - 1
 with the minimum number of jumps.

 From any index `i`, you can:
 1. Move to `i - 1` or `i + 1`
 2. If `nums[i]` is a prime number, you can jump to any index `j`
    where `nums[j]` is a multiple of `nums[i]`

 Strategy:
 - Use Breadth-First Search (BFS) since we need the shortest path.
 - Precompute all prime numbers up to a fixed limit using Sieve of Eratosthenes.
 - Maintain a mapping from value → list of indices for fast lookup.
 - For each index:
     - Try adjacent moves (i - 1, i + 1)
     - If value is prime and not processed before:
         - Jump to all indices whose values are multiples of it
 - Use a `visitedPrimeValues` set to avoid redundant processing.

 Time Complexity:
 - Sieve: O(N log log N)
 - BFS traversal: O(N + total multiples traversed)
 - Overall: ~O(N log log N)

 Space Complexity:
 - O(N) for BFS structures and mappings
 */

class Solution {
    func minJumps(_ nums: [Int]) -> Int {
        let maxLimit = 1_000_001
        
        // Step 1: Precompute primes using Sieve of Eratosthenes
        var isPrime = Array(repeating: true, count: maxLimit)
        isPrime[0] = false
        isPrime[1] = false
        
        let sieveLimit = Int(Double(maxLimit).squareRoot())
        
        if sieveLimit >= 2 {
            for number in 2...sieveLimit {
                if isPrime[number] {
                    var multiple = number * number
                    while multiple < maxLimit {
                        isPrime[multiple] = false
                        multiple += number
                    }
                }
            }
        }
        
        let n = nums.count
        
        // Step 2: Build value → indices mapping
        var valueToIndices: [Int: [Int]] = [:]
        var maxValueInArray = 0
        
        for (index, value) in nums.enumerated() {
            valueToIndices[value, default: []].append(index)
            maxValueInArray = max(maxValueInArray, value)
        }
        
        // Step 3: BFS setup
        var distances = Array(repeating: Int.max, count: n)
        distances[0] = 0
        
        var queue: [Int] = [0]
        var head = 0
        
        // Track which prime values we've already processed
        var visitedPrimeValues = Set<Int>()
        
        // Step 4: BFS traversal
        while head < queue.count {
            let currentIndex = queue[head]
            head += 1
            
            let currentDistance = distances[currentIndex]
            
            // Move to index - 1
            if currentIndex - 1 >= 0 && distances[currentIndex - 1] == Int.max {
                distances[currentIndex - 1] = currentDistance + 1
                queue.append(currentIndex - 1)
            }
            
            // Move to index + 1
            if currentIndex + 1 < n && distances[currentIndex + 1] == Int.max {
                distances[currentIndex + 1] = currentDistance + 1
                queue.append(currentIndex + 1)
            }
            
            let currentValue = nums[currentIndex]
            
            // Only process prime-based jumps once per value
            if !isPrime[currentValue] || visitedPrimeValues.contains(currentValue) {
                continue
            }
            
            // Step 5: Jump to all multiples of current prime value
            var multiplier = 1
            
            while true {
                let targetValue = currentValue * multiplier
                
                // Stop if we exceed max value in array
                if targetValue > maxValueInArray {
                    break
                }
                
                // Visit all indices having this value
                if let indices = valueToIndices[targetValue] {
                    for nextIndex in indices where distances[nextIndex] == Int.max {
                        distances[nextIndex] = currentDistance + 1
                        queue.append(nextIndex)
                    }
                }
                
                multiplier += 1
            }
            
            // Mark this prime value as processed
            visitedPrimeValues.insert(currentValue)
            
            // Early exit if target reached
            if distances[n - 1] != Int.max {
                break
            }
        }
        
        return distances[n - 1]
    }
}