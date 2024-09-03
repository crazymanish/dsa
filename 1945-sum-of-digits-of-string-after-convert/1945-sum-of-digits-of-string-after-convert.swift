class Solution {
    func getLucky(_ s: String, _ k: Int) -> Int {
        let positionInAlphabet: [Character: Int] = {
            let chars = "abcdefghijklmnopqrstuvwxyz"
            return chars.enumerated().reduce(into: [:]) { $0[$1.1] = $1.0 + 1 }
        }()
        
        // First, convert s into an array of integers by replacing each 
        // letter with its position in the alphabet.
        let ints = s.map { positionInAlphabet[$0]! }

        // Then, transform the integer by replacing it with the sum of its digits.
        var sum = ints.reduce(0) { $0 + $1 / 10 + $1 % 10 }

        // Repeat the transform operation k times in total.
        for _ in 0..<k - 1 {
            var (num, newSum) = (sum, 0)
            while num > 0 { (num, newSum) = (num / 10, newSum + num % 10) }
            sum = newSum
        }
        
        return sum
    }
}