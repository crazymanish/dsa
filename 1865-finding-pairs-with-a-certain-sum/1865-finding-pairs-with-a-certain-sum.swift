// Time and Space Complexity Analysis:
// n = length of nums1
// m = length of nums2
// k = number of unique elements in nums2

class FindSumPairs {
    private let firstArray: [Int]
    private var secondArray: [Int]
    private var secondArrayFrequency: [Int: Int]

    // init:
    // Time: O(m) - We iterate through nums2 once to build the frequency map.
    // Space: O(m + k) - We store copies of both arrays and the frequency map.
    init(_ nums1: [Int], _ nums2: [Int]) {
        self.firstArray = nums1
        self.secondArray = nums2
        self.secondArrayFrequency = [:]

        // Pre-compute the frequency of each number in the second array.
        for number in secondArray {
            secondArrayFrequency[number, default: 0] += 1
        }
    }

    // add:
    // Time: O(1) - Dictionary lookups and updates are average-case O(1).
    // Space: O(1) - No new significant memory is allocated.
    func add(_ index: Int, _ value: Int) {
        // Ensure the index is within the bounds of the second array.
        guard secondArray.indices.contains(index) else { return }

        // Decrease the frequency of the old number.
        let oldNumber = secondArray[index]
        secondArrayFrequency[oldNumber]? -= 1
        
        // Update the number in the second array.
        secondArray[index] += value
        
        // Increase the frequency of the new number.
        let newNumber = secondArray[index]
        secondArrayFrequency[newNumber, default: 0] += 1
    }

    // count:
    // Time: O(n) - We iterate through the first array.
    // Space: O(1) - No new significant memory is allocated.
    func count(_ total: Int) -> Int {
        var pairCount = 0
        
        // For each number in the first array...
        for number in firstArray {
            // ...calculate the required complement to reach the total.
            let complement = total - number
            
            // Add the number of times this complement appears in the second array.
            pairCount += secondArrayFrequency[complement] ?? 0
        }
        
        return pairCount
    }
}

/**
 * Your FindSumPairs object will be instantiated and called as such:
 * let obj = FindSumPairs(nums1, nums2)
 * obj.add(index, val)
 * let ret_2: Int = obj.count(tot)
 */