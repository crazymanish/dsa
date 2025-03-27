class Solution {
    func minimumIndex(_ nums: [Int]) -> Int {
        let n = nums.count
        var elementCounts = [Int: Int]() // Dictionary to store element frequencies
        var dominantElement: Int? // Dominant element, if found
        var maxFrequency = 0 // Maximum frequency of an element

        // Find the dominant element in the entire array
        for number in nums {
            elementCounts[number, default: 0] += 1
            if elementCounts[number]! > n / 2 {
                dominantElement = number
                maxFrequency = elementCounts[number]!
            }
        }

        // If no dominant element exists, no split is possible
        guard let dominant = dominantElement else { return -1 }

        var leftCount = 0 // Frequency of dominant element in the left subarray

        // Iterate through the array to find a valid split index
        for i in 0..<n - 1 {
            if nums[i] == dominant {
                leftCount += 1 // Increment left count if the element is the dominant element
            }

            let leftLength = i + 1 // Length of the left subarray
            let rightLength = n - 1 - i // Length of the right subarray

            // Check if the dominant element is dominant in both subarrays
            if leftCount * 2 > leftLength && (maxFrequency - leftCount) * 2 > rightLength {
                return i // Found a valid split index
            }
        }

        return -1 // No valid split index found
    }
}