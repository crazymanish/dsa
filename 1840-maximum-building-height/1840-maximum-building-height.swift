class Solution {
    /**
     Problem Summary:
     Find the maximum possible height of any building from 1...n, where:
     - Building 1 must have height 0.
     - Adjacent buildings can differ by at most 1.
     - Some buildings have maximum height restrictions.

     Strategy:
     Sort restrictions by building index, add implicit restrictions for building 1 and building n,
     then normalize restrictions from left-to-right and right-to-left.
     Finally, compute the highest possible peak between every pair of restricted buildings.

     Time Complexity: O(m log m), where m is the number of restrictions.
     Space Complexity: O(m)
     */
    func maxBuilding(_ n: Int, _ restrictions: [[Int]]) -> Int {
        var buildingLimits = restrictions.sorted { $0[0] < $1[0] }

        // Building 1 must always have height 0.
        buildingLimits.insert([1, 0], at: 0)

        // If building n is not restricted, it can be at most n - 1.
        if buildingLimits.last?[0] != n {
            buildingLimits.append([n, n - 1])
        }

        // Left-to-right pass:
        // Each building cannot exceed previous height + distance.
        for index in 1..<buildingLimits.count {
            let distance = buildingLimits[index][0] - buildingLimits[index - 1][0]
            buildingLimits[index][1] = min(
                buildingLimits[index][1],
                buildingLimits[index - 1][1] + distance
            )
        }

        // Right-to-left pass:
        // Each building cannot exceed next height + distance.
        for index in stride(from: buildingLimits.count - 2, through: 0, by: -1) {
            let distance = buildingLimits[index + 1][0] - buildingLimits[index][0]
            buildingLimits[index][1] = min(
                buildingLimits[index][1],
                buildingLimits[index + 1][1] + distance
            )
        }

        var maximumHeight = 0

        // Between two restricted buildings, the highest peak is limited by both sides.
        for index in 1..<buildingLimits.count {
            let leftBuilding = buildingLimits[index - 1][0]
            let leftHeight = buildingLimits[index - 1][1]
            let rightBuilding = buildingLimits[index][0]
            let rightHeight = buildingLimits[index][1]

            let distance = rightBuilding - leftBuilding
            let possiblePeakHeight = (leftHeight + rightHeight + distance) / 2

            maximumHeight = max(maximumHeight, possiblePeakHeight)
        }

        return maximumHeight
    }
}