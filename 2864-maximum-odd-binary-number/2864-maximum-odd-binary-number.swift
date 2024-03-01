class Solution {
    func maximumOddBinaryNumber(_ s: String) -> String {
        let ones = s.filter({ $0 == "1" }).count
        let zeros = s.count - ones

        return String(repeating: "1", count: ones-1) + String(repeating: "0", count: zeros) + "1"
    }
}