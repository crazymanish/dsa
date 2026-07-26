final class Solution {
    /**
     Problem Summary:
     Find the maximum product of any three integers in the array.

     Strategy:
     Track the two smallest values and the three largest values.
     The maximum product must be one of:
     - the two smallest values multiplied by the largest value
     - the three largest values multiplied together

     Time Complexity: O(n)
     Space Complexity: O(1)
     */
    func maximumProduct(_ nums: [Int]) -> Int {
        var smallest = Int.max
        var secondSmallest = Int.max

        var largest = Int.min
        var secondLargest = Int.min
        var thirdLargest = Int.min

        for number in nums {
            // Keep the two smallest values, which may form a positive product
            // when multiplied together with the largest value.
            if number <= smallest {
                secondSmallest = smallest
                smallest = number
            } else if number < secondSmallest {
                secondSmallest = number
            }

            // Keep the three largest values for the all-positive candidate.
            if number >= largest {
                thirdLargest = secondLargest
                secondLargest = largest
                largest = number
            } else if number >= secondLargest {
                thirdLargest = secondLargest
                secondLargest = number
            } else if number > thirdLargest {
                thirdLargest = number
            }
        }

        let productUsingTwoSmallest = smallest * secondSmallest * largest
        let productUsingThreeLargest = largest * secondLargest * thirdLargest

        // The optimal product comes from either two negative values
        // or the three largest values.
        return max(productUsingTwoSmallest, productUsingThreeLargest)
    }
}