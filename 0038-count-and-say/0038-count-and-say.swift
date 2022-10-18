class Solution {
    func countAndSay(_ n: Int) -> String {
        var string = [1]
        for _ in 1 ..< n {
            string = count(string)
        }
        
        return string.compactMap{String($0)}.joined()
    }
    
    func count(_ digits: [Int]) -> [Int] {
        var counts: [(digit: Int, count: Int)] = digits.reduce(into: []) { (counts, digit) in
            if counts.last?.digit == digit {
                counts[counts.endIndex-1].count += 1
            } else {
                counts.append((digit, 1))
            }
        }
        
        return counts.flatMap { [$0.count, $0.digit] }
    }
}