class Solution {
    func fullBloomFlowers(_ flowers: [[Int]], _ people: [Int]) -> [Int] {
        // Create two arrays to store the sorted start and end times of full blooms.
        var starts: [Int] = []
        var ends: [Int] = []
        
        // Extract start and end times from the 'flowers' array and adjust for inclusivity.
        flowers.forEach {
            starts.append($0[0])
            // Add 1 to the end time to account for the inclusive bloom time range.
            ends.append($0[1] + 1)
        }
        
        // Sort both arrays in ascending order.
        starts.sort()
        ends.sort()

        // Define a binary search function.
        func binarySearch(_ nums: [Int], _ target: Int) -> Int {
            var left = 0
            var right = nums.count
            
            while left < right {
                let mid = (left+right) / 2
                if target < nums[mid] {
                    right = mid
                } else {
                    left = mid + 1
                }
            }
            
            return left
        }

        // Map the bloom times of people to the number of flowers in bloom at that time.
        return people.map {
            let flowersStartedToBloom = binarySearch(starts, $0)
            let flowersEndedToBloom = binarySearch(ends, $0)
            return flowersStartedToBloom - flowersEndedToBloom
        }
    }
}