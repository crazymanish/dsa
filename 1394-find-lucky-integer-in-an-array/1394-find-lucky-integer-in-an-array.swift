// Time Complexity: O(n)
// Space Complexity: O(k) where k is the number of unique elements in the array

class Solution {
    func findLucky(_ numbers: [Int]) -> Int {
        // Create a frequency map of the numbers in the input array.
        var frequencyMap: [Int: Int] = [:]
        for number in numbers {
            frequencyMap[number, default: 0] += 1
        }
        
        // Initialize the result to -1, indicating no lucky number found yet.
        var largestLuckyNumber = -1
        
        // Iterate through the frequency map to find the largest lucky number.
        for (number, count) in frequencyMap {
            if number == count {
                largestLuckyNumber = max(largestLuckyNumber, number)
            }
        }
        
        return largestLuckyNumber
    }
}