class Solution {
    func singleNumber(_ nums: [Int]) -> [Int] {
        // Step 1: XOR all the numbers in the array.
        // This will give us the XOR of the two unique numbers.
        let combinedXOR = nums.reduce(0, ^)
    
        // Step 2: Find the rightmost set bit in the combinedXOR.
        // This bit is different between the two unique numbers.
        let rightmostSetBit = combinedXOR & -combinedXOR
    
        // Step 3: Initialize two variables to hold the two unique numbers.
        var uniqueNumber1 = 0
        var uniqueNumber2 = 0
    
        // Step 4: Partition the numbers into two groups based on the rightmost set bit.
        // XOR each group separately to isolate the two unique numbers.
        for num in nums {
            if num & rightmostSetBit == 0 {
                uniqueNumber1 ^= num
            } else {
                uniqueNumber2 ^= num
            }
        }
    
        // Step 5: Return the two unique numbers.
        return [uniqueNumber1, uniqueNumber2]
    }
}