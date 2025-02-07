class Solution {
    func queryResults(_ limit: Int, _ queries: [[Int]]) -> [Int] {
        // Dictionary to store the frequency of each color (color -> count).
        var colorFrequencies = [Int: Int]()
        
        // Dictionary to store the color assigned to each ball (ball -> color).
        var ballColors = [Int: Int]()
        
        // Array to store the result (number of distinct colors after each query).
        var distinctColorCounts = [Int]()

        for query in queries {
            let ball = query[0] // Ball number.
            let color = query[1] // Color to be assigned.

            // Check if the ball already had a color assigned.
            if let oldColor = ballColors[ball] {
                // Decrement the frequency of the old color.
                colorFrequencies[oldColor]! -= 1
                
                // If the frequency of the old color becomes zero, remove it from the frequency dictionary.
                if colorFrequencies[oldColor]! == 0 { 
                    colorFrequencies[oldColor] = nil 
                }
            }

            // Assign the new color to the ball.
            ballColors[ball] = color
            
            // Increment the frequency of the new color (or initialize it to 1 if it's new).
            colorFrequencies[color, default: 0] += 1
            
            // The number of distinct colors is simply the number of keys in the colorFrequencies dictionary.
            distinctColorCounts.append(colorFrequencies.count)
        }

        return distinctColorCounts // Return the array of distinct color counts.
    }
}