// https://leetcode.com/problems/number-of-rectangles-that-can-form-the-largest-square

class Solution {
    func countGoodRectangles(_ rectangles: [[Int]]) -> Int {
        var hashMap: [Int : Int] = [:]
        
        for rectangle in rectangles {
            let minLength = min(rectangle[0], rectangle[1])
            
            let hashMapValue = hashMap[minLength] ?? 0
            hashMap[minLength] = hashMapValue + 1
        }
        
        var maxKey = Int.min
        for (key, _) in hashMap {
            maxKey = max(maxKey, key)
        }
        
        return hashMap[maxKey] ?? 0
    }
}