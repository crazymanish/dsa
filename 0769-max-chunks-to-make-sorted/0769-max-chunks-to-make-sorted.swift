class Solution {
    func maxChunksToSorted(_ arr: [Int]) -> Int {
        var maxSoFar = 0
        var chunks = 0
    
        for i in 0..<arr.count {
            maxSoFar = max(maxSoFar, arr[i])
            
            if maxSoFar == i {
                chunks += 1
            }
        }
    
        return chunks
    }
}