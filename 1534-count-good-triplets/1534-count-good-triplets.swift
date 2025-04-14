class Solution {
    func countGoodTriplets(_ arr: [Int], _ a: Int, _ b: Int, _ c: Int) -> Int {
        let arrayLength = arr.count // Store the length of the array for efficiency
        var goodTripletCount = 0 // Initialize the count of good triplets

        // Iterate through all possible triplets (i, j, k) where i < j < k
        for firstElementIndex in 0..<arrayLength {
            for secondElementIndex in (firstElementIndex + 1)..<arrayLength {
                // Check the first condition: |arr[i] - arr[j]| <= a
                let firstCondition = abs(arr[firstElementIndex] - arr[secondElementIndex]) <= a

                // If the first condition is false, no need to check further for this i and j
                if firstCondition {
                    for thirdElementIndex in (secondElementIndex + 1)..<arrayLength {
                        // Check the second condition: |arr[j] - arr[k]| <= b
                        let secondCondition = abs(arr[secondElementIndex] - arr[thirdElementIndex]) <= b
                        // Check the third condition: |arr[i] - arr[k]| <= c
                        let thirdCondition = abs(arr[firstElementIndex] - arr[thirdElementIndex]) <= c

                        // If all conditions are met, increment the counter
                        if firstCondition && secondCondition && thirdCondition {
                            goodTripletCount += 1
                        }
                    }
                }
            }
        }

        return goodTripletCount // Return the total count of good triplets
    }
}