class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n log n)
    ///     - n = number of squares
    ///     - We create 2n sweep events.
    ///     - Each event updates a segment tree in O(log n).
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     - Coordinate compression
    ///     - Segment tree storage
    ///     - Event list
    ///
    /// Problem Summary:
    ///   Given multiple axis-aligned squares, find a horizontal line y = Y
    ///   such that the total area of square parts below the line equals
    ///   exactly half of the total area.
    ///
    /// Approach:
    ///   - Use a vertical sweep line over Y.
    ///   - Maintain active x-interval coverage using a segment tree.
    ///   - Accumulate horizontal strips with constant covered width.
    ///   - Locate the strip where cumulative area crosses half.
    /// -----------------------------------------------------------------------
    func separateSquares(_ squares: [[Int]]) -> Double {

        /// Sweep-line event:
        ///   y        → vertical position
        ///   xStart   → interval start
        ///   xEnd     → interval end
        ///   delta    → +1 (enter square), -1 (leave square)
        struct SweepEvent {
            let y: Double
            let xStart: Double
            let xEnd: Double
            let delta: Int
        }

        var xCoordinates = [Double]()
        var events = [SweepEvent]()

        // Build events and collect x-coordinates
        for square in squares {
            let x = Double(square[0])
            let y = Double(square[1])
            let side = Double(square[2])

            xCoordinates.append(x)
            xCoordinates.append(x + side)

            events.append(SweepEvent(y: y, xStart: x, xEnd: x + side, delta: 1))
            events.append(SweepEvent(y: y + side, xStart: x, xEnd: x + side, delta: -1))
        }

        // Coordinate compression for x-axis
        xCoordinates.sort()
        xCoordinates = uniqueSorted(xCoordinates)

        // Sort events by Y-coordinate
        events.sort { $0.y < $1.y }

        let compressedCount = xCoordinates.count

        // Segment tree:
        // coverCount[node] = number of active intervals covering this segment
        // coveredLength[node] = total x-length covered in this segment
        var coverCount = Array(repeating: 0, count: 4 * compressedCount)
        var coveredLength = Array(repeating: 0.0, count: 4 * compressedCount)

        // Map x-coordinate → compressed index
        var indexOfX = [Double: Int]()
        for (i, x) in xCoordinates.enumerated() {
            indexOfX[x] = i
        }

        /// Updates segment tree coverage on interval [left, right)
        func updateSegmentTree(
            _ node: Int,
            _ left: Int,
            _ right: Int,
            _ queryLeft: Int,
            _ queryRight: Int,
            _ delta: Int
        ) {
            if queryRight <= left || right <= queryLeft { return }

            if queryLeft <= left && right <= queryRight {
                coverCount[node] += delta
            } else {
                let mid = (left + right) >> 1
                updateSegmentTree(node << 1, left, mid, queryLeft, queryRight, delta)
                updateSegmentTree(node << 1 | 1, mid, right, queryLeft, queryRight, delta)
            }

            if coverCount[node] > 0 {
                coveredLength[node] = xCoordinates[right] - xCoordinates[left]
            } else if right - left == 1 {
                coveredLength[node] = 0
            } else {
                coveredLength[node] =
                    coveredLength[node << 1] + coveredLength[node << 1 | 1]
            }
        }

        // Accumulate horizontal strips: (startY, height, coveredWidth)
        var totalArea = 0.0
        var previousY = events[0].y
        var strips = [(startY: Double, height: Double, width: Double)]()

        for event in events {
            if event.y > previousY {
                let height = event.y - previousY
                let width = coveredLength[1]

                totalArea += width * height
                strips.append((previousY, height, width))

                previousY = event.y
            }

            let leftIndex = indexOfX[event.xStart]!
            let rightIndex = indexOfX[event.xEnd]!
            updateSegmentTree(1, 0, compressedCount - 1, leftIndex, rightIndex, event.delta)
        }

        // Find the Y where cumulative area reaches half
        let halfArea = totalArea / 2.0
        var accumulated = 0.0

        for strip in strips {
            let stripArea = strip.height * strip.width
            if accumulated + stripArea >= halfArea {
                return strip.startY + (halfArea - accumulated) / strip.width
            }
            accumulated += stripArea
        }

        return 0.0
    }

    /// Removes duplicates from a sorted array
    private func uniqueSorted(_ values: [Double]) -> [Double] {
        var result = [Double]()
        for v in values {
            if result.last != v {
                result.append(v)
            }
        }
        return result
    }
}
