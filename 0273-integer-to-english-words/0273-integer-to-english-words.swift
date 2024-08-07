class Solution {
    func numberToWords(_ num: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut

        return numberFormatter.string(from: NSNumber(value: num))!
        .replacingOccurrences(of: "-", with: " ")
        .capitalized
    }
}