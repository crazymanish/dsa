class Solution {
    func goodTriplets(_ nums1: [Int], _ nums2: [Int]) -> Int {
        let arrayLength = nums1.count // Length of the input arrays

        // Map each number to its index in nums1 for efficient lookup.
        var numberToIndexMap = Array(repeating: 0, count: arrayLength)
        for i in 0..<arrayLength {
            numberToIndexMap[nums1[i]] = i
        }

        var leftSmallerCounts = FenwickTree(arrayLength) // Fenwick Tree to count smaller elements to the left
        var goodTripletCount = 0 // Initialize the count of good triplets

        // Iterate through nums2 to find potential middle elements of good triplets
        for (currentIndex, currentNumber) in nums2.enumerated() {
            let convertedIndex = numberToIndexMap[currentNumber] // Get the index of the current number in nums1
            let smallerElementsToLeft = leftSmallerCounts.querySum(convertedIndex - 1) // Count elements smaller to the left
            let largerElementsToRight = (arrayLength - convertedIndex - 1) - (currentIndex - smallerElementsToLeft) // Count elements larger to the right
            leftSmallerCounts.updateValue(at: convertedIndex, by: 1) // Update the Fenwick Tree
            goodTripletCount += smallerElementsToLeft * largerElementsToRight // Add the count of good triplets formed
        }

        return goodTripletCount // Return the total count of good triplets
    }
}

// Fenwick Tree (Binary Indexed Tree) implementation
class FenwickTree {
    private var data: [Int] // Array to store the Fenwick Tree data

    // Initialize the Fenwick Tree with an array of size n+1
    init(_ arrayLength: Int) {
        data = Array(repeating: 0, count: arrayLength + 1)
    }

    // Update the value at a given index in the Fenwick Tree
    func updateValue(at index: Int, by value: Int) {
        var currentIndex = index + 1 // Adjust index for Fenwick Tree (1-based indexing)
        while currentIndex < data.count {
            data[currentIndex] += value // Add value to the current node
            currentIndex += currentIndex & -currentIndex // Move to the next node in the tree
        }
    }

    // Calculate the sum of values up to a given index in the Fenwick Tree
    func querySum(_ index: Int) -> Int {
        var sum = 0 // Initialize the sum
        var currentIndex = index + 1 // Adjust index for Fenwick Tree (1-based indexing)
        while currentIndex > 0 {
            sum += data[currentIndex] // Add the value of the current node
            currentIndex -= currentIndex & -currentIndex // Move to the parent node in the tree
        }
        return sum // Return the calculated sum
    }
}