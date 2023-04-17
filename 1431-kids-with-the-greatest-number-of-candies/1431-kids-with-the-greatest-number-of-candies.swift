class Solution {
    func kidsWithCandies(_ candies: [Int], _ extraCandies: Int) -> [Bool] {
        var output: [Bool] = []
        
        var maximumCandy = Int.min
        for candy in candies {
            maximumCandy = max(maximumCandy, candy)
        }
        
        for candy in candies {
            if candy + extraCandies >= maximumCandy {
                output.append(true)
            } else {
                output.append(false)
            }
        }
        
        return output
    }
}