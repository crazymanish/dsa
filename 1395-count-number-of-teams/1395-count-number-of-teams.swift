class Solution {
    func numTeams(_ rating: [Int]) -> Int {
        var ascendingTeamCount = 0
        var descendingTeamCount = 0
        
        func findSmallLargerCount(_ currentElement: Int, _ startIndex: Int, _ endIndex: Int) -> (Int, Int) {
            var smaller = 0
            var larger = 0
            
            for index in startIndex..<endIndex {
                if rating[index] < currentElement {
                    smaller += 1
                } else {
                    larger += 1
                }
            }
            
            return (smaller, larger)
        }
        
        for index in 0..<rating.count {
            let currentElement = rating[index]
            
            // (smaller,larger) count in left and right side
            let (leftSmaller, leftLarger) = findSmallLargerCount(currentElement, 0, index) 
            let (rightSmaller, rightLarger) = findSmallLargerCount(currentElement, index+1, rating.count)
            
            ascendingTeamCount += leftSmaller * rightLarger
            descendingTeamCount += leftLarger * rightSmaller
        }
        
        return ascendingTeamCount + descendingTeamCount
    }
}