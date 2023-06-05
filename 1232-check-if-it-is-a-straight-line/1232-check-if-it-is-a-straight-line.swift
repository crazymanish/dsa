class Solution {
    func checkStraightLine(_ coordinates: [[Int]]) -> Bool {
      if coordinates.isEmpty { return false }

      let coordinatesCount = coordinates.count

      guard coordinatesCount >= 2 else { return false }

      let xDiff = coordinates[1][0] - coordinates[0][0]
      let yDiff = coordinates[1][1] - coordinates[0][1]

      for i in 2..<coordinatesCount {
        let xDist = coordinates[i][0] - coordinates[0][0]
        let yDist = coordinates[i][1] - coordinates[0][1]

        if xDist * yDiff != yDist * xDiff {
          return false
        }
      }

      return true
    }
}