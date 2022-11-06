class Solution {
    func orderlyQueue(_ s: String, _ k: Int) -> String {
        var array = Array(s)
        
        if k == 1 {
            var result = String(array)
            for i in 0..<s.count {
                result = min(result, String(array[i..<array.endIndex] + array[0..<i]))
            }
            return result
        } else {
            return String(array.sorted { $0 < $1 })
        }
    }
}