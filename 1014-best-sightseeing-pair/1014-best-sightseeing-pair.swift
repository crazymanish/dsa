class Solution {
    func maxScoreSightseeingPair(_ values: [Int]) -> Int {
        var maxScore = 0
        var maxI = values[0] + 0
    
        for j in 1..<values.count {
            // Calculate the score for the pair (i, j)
            let score = maxI + values[j] - j
            
            // Update the maximum score
            maxScore = max(maxScore, score)
            
            // Update maxI to be the maximum of the current maxI and values[j] + j
            maxI = max(maxI, values[j] + j)
        }
    
        return maxScore
    }
}

/*
Explanation

Initialization:
maxScore is initialized to 0 to store the maximum score found.
maxI is initialized to values[0] + 0 to store the maximum value of values[i] + i seen so far.

Iteration:
We iterate through the array starting from the second element (j = 1).

Score Calculation:
- For each element values[j], we calculate the score using the formula maxI + values[j] - j.
- maxI represents the maximum value of values[i] + i seen so far, and values[j] - j represents the current element's contribution to the score.

Update Maximum Score:
We update maxScore if the calculated score is greater than the current maxScore.

Update maxI:
We update maxI to be the maximum of the current maxI and values[j] + j. This ensures that maxI always holds the maximum value of values[i] + i seen so far.

Return Result:
After iterating through the array, we return maxScore as the result.

Example
Let's go through an example to see how the algorithm works:
Initialize maxScore = 0 and maxI = values[0] + 0 = 8.

Iterate through the array:
For j = 1: score = 8 + 1 - 1 = 8, maxScore = 8, maxI = max(8, 1 + 1) = 8.
For j = 2: score = 8 + 5 - 2 = 11, maxScore = 11, maxI = max(8, 5 + 2) = 8.
For j = 3: score = 8 + 2 - 3 = 7, maxScore = 11, maxI = max(8, 2 + 3) = 8.
For j = 4: score = 8 + 6 - 4 = 10, maxScore = 11, maxI = max(8, 6 + 4) = 10.
The maximum score is 11, which is the result.

This approach ensures that we find the maximum score efficiently in O(n) time complexity.
*/