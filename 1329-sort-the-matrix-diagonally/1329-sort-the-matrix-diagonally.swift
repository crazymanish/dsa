class Solution {
    func diagonalSort(_ mat: [[Int]]) -> [[Int]] {
	    let rows = mat.count
	    let columns  = mat[0].count
	    var result = Array(repeating: Array(repeating: 0, count: columns), count: rows)
	    var groupDict = [Int: [Int]]()

	    for row in 0..<rows {
		    for column in 0..<columns {
			    let key = row - column
			    if groupDict[key] == nil { groupDict[key] = [Int]() }
			    groupDict[key]!.append(mat[row][column])
		    }
	    }

	    for key in groupDict.keys {
		    groupDict[key]!.sort()
	    }

	    for row in 0..<rows {
		    for column in 0..<columns {
                let key = row - column
			    result[row][column] = groupDict[key]!.removeFirst()
		    }
	    }

	    return result
    }
}

