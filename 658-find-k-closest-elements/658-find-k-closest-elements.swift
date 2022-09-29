class Solution {
    func findClosestElements(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
        var result = [Int]()
        var startIndex = 0
        var endIndex = arr.count - 1
        
        while(endIndex - startIndex >= k) {
            if abs(arr[startIndex] - x) > abs(arr[endIndex] - x) {
                startIndex += 1
            }
            else {
                endIndex -= 1
            }
        }
        
        for i in startIndex...endIndex {
            result.append(arr[i])
        }
        
        return result
    }
}