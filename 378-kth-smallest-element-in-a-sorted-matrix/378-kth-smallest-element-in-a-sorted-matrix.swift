class Solution {
    func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
        var inputArray: [Int] = []
        for row in matrix { inputArray += row }
        inputArray = inputArray.sorted()
        
        return inputArray[k-1]
    }
}


class Solution {
    func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
        let n = matrix.count
        
        var minElement = matrix[0][0]
        var maxElement = matrix[n-1][n-1]
        
        while minElement != maxElement {
            let midElement = minElement + (maxElement - minElement) / 2
            var minElementsThanMidElement = 0
            
            for row in 0..<n {
                for column in 0..<n {
                    if matrix[row][column] > midElement { break }
                    
                    minElementsThanMidElement += 1
                }
            }
            
            if minElementsThanMidElement < k {
                minElement = midElement + 1
            } else {
                maxElement = midElement
            }
        }
        
        return minElement
    }
}
