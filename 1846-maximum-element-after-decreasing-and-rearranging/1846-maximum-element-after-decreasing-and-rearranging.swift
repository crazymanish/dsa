class Solution {
    func maximumElementAfterDecrementingAndRearranging(_ arr: [Int]) -> Int {
        var result = 0
        
        for num in arr.sorted() {
            result = num > result ? result+1 : result       
        }
        
        return result
    }
}