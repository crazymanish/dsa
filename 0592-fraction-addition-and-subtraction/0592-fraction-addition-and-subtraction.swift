import Algorithms

class Solution {
    struct Fraction {
        let num: Int
        let den: Int

        // Initializes a fraction converting it to its irreducible form.
        init(_ num: Int, _ den: Int) {
            let div = gcd(abs(num), abs(den))
            self.num = num / div
            self.den = den / div

            func gcd(_ a: Int, _ b: Int) -> Int { b == 0 ? a : gcd(b, a % b) }    
        }

        // Infix operator to add 2 fractions.
        static func + (_ a: Fraction, _ b: Fraction) -> Fraction {
            Fraction(a.num * b.den + b.num * a.den, a.den * b.den)
        }
    }

    func fractionAddition(_ expression: String) -> String {
        // Convert the expression into an array of fractions.
        let fractions: [Fraction] = expression            // "-1/10+1/2"
            .split(separator: "/")                        // ["-1", "10+1", "2"]
            .flatMap { $0.chunked { $1.isWholeNumber } }  // ["-1", "10", "+1", "2"]
            .compactMap { Int($0) }                       // [-1, 10, 1, 2]
            .chunks(ofCount: 2)                           // [[-1, 10], [1, 2]] in chunked form
            .map { Array($0) }                            // [[-1, 10], [1, 2]]
            .map { Fraction($0[0], $0[1]) }               // [Fraction(-1, 10), Fraction(1, 2)]

        // Add all the fractions.
        let res = fractions.reduce(Fraction(0, 1), +)

        return "\(res.num)/\(res.den)"
    }
}