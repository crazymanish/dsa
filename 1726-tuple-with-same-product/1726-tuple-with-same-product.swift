class Solution {
    func tupleSameProduct(_ nums: [Int]) -> Int {
        // Dictionary to store the product of pairs and their counts
        var productToCount = [Int: Int]()
        var totalTuples = 0
        
        // Iterate through all pairs of numbers in the array
        for i in 0..<nums.count {
            for j in i + 1..<nums.count {
                let product = nums[i] * nums[j]
                
                // If the product has been seen before, calculate the number of new tuples
                if let count = productToCount[product] {
                    totalTuples += count * 8 // Each pair can form 8 tuples
                    productToCount[product] = count + 1
                } else {
                    productToCount[product] = 1
                }
            }
        }
        
        return totalTuples
    }
}