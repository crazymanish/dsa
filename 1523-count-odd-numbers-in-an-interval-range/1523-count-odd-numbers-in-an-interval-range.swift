class Solution {
    func countOdds(_ low: Int, _ high: Int) -> Int {
        guard low != high else {
            return low.isEven ? 0 : 1
        }
        
        // count of numbers in between
        let count = (high - low) - 1
        
        switch (low.isEven, high.isEven) {
            case (true, true):
                return (count / 2) + 1
            case (false, false):
                return (count / 2) + 2
            default:
                return (count / 2) + 1
        }
    }
}

extension Int {
    var isEven: Bool { self % 2 == 0 }
}