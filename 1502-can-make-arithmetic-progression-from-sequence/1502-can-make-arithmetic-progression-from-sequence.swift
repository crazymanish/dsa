class Solution {
    func canMakeArithmeticProgression(_ arr: [Int]) -> Bool {
        let sortedArray = arr.sorted { $0 > $1 }
        let diff = abs(sortedArray[0] - sortedArray[1])
    
        for index in 0..<sortedArray.count-1 {
            if abs(sortedArray[index] - sortedArray[index+1]) != diff {
                return false
            }
        }
    
        return true
    }
}