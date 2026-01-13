class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n log R)
    ///     - n = number of squares
    ///     - R = vertical search range (from lowest bottom to highest top)
    ///     Each binary search step computes area in O(n).
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     - We store all squares in a structured form.
    ///
    /// Problem Summary:
    ///   Given several axis-aligned squares, find a horizontal line y = Y
    ///   such that the total area of all square parts BELOW the line equals
    ///   half of the total area.
    ///
    /// Approach:
    ///   - Compute the total area of all squares.
    ///   - Binary search on Y between the minimum bottom and maximum top.
    ///   - For a candidate Y, compute the accumulated area below Y.
    ///   - Adjust the search range until the desired precision is reached.
    /// -----------------------------------------------------------------------
    func separateSquares(_ squares: [[Int]]) -> Double {
        
        // Helper model for a square
        struct Square {
            let leftX: Double
            let bottomY: Double
            let sideLength: Double
            
            init(_ data: [Int]) {
                self.leftX = Double(data[0])
                self.bottomY = Double(data[1])
                self.sideLength = Double(data[2])
            }
            
            var area: Double {
                sideLength * sideLength
            }
            
            var topY: Double {
                bottomY + sideLength
            }
        }
        
        // Convert input into Square structs
        let squareList = squares.map(Square.init)
        
        // Total area of all squares
        let totalArea = squareList.reduce(0.0) { $0 + $1.area }
        let targetAreaBelowLine = totalArea / 2.0
        
        // Vertical search bounds
        let minPossibleY = squareList.map { $0.bottomY }.min()!
        let maxPossibleY = squareList.map { $0.topY }.max()!
        
        /// Computes the area of a single square BELOW the horizontal line y = cutY
        func areaBelowLine(for square: Square, cutY: Double) -> Double {
            // Entire square is above the line
            if cutY <= square.bottomY {
                return 0.0
            }
            
            // Entire square is below the line
            if cutY >= square.topY {
                return square.area
            }
            
            // Partial overlap
            let coveredHeight = cutY - square.bottomY
            let ratio = coveredHeight / square.sideLength
            return square.area * ratio
        }
        
        /// Computes the total area below the horizontal line y = cutY
        func totalAreaBelowLine(cutY: Double) -> Double {
            var sum = 0.0
            for square in squareList {
                sum += areaBelowLine(for: square, cutY: cutY)
            }
            return sum
        }
        
        // Binary search for the separating Y coordinate
        var low = minPossibleY
        var high = maxPossibleY
        var answerY = minPossibleY
        
        // Precision threshold
        let epsilon = 1e-5
        
        while high - low > epsilon {
            let midY = (low + high) / 2.0
            let areaBelow = totalAreaBelowLine(cutY: midY)
            
            if areaBelow >= targetAreaBelowLine {
                answerY = midY
                high = midY
            } else {
                low = midY
            }
        }
        
        return answerY
    }
}
