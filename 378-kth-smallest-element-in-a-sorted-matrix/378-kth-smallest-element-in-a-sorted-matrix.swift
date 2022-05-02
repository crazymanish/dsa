class Solution {
    func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
        var inputArray: [Int] = []
        for row in matrix { inputArray += row }
        inputArray = inputArray.sorted()
        
        return inputArray[k-1]
    }
}