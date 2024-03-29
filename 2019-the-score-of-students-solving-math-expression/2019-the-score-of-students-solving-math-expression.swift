class Solution {
    func scoreOfStudents(_ s: String, _ answers: [Int]) -> Int {
        func parse() -> Int {
            let v1 = Unicode.Scalar("0").value
            var res = 0
            var num = 0
            var multResult = 1
        
            for c in s {
                switch c {
                case "+":
                    res += num * multResult
                    multResult = 1
                    num = 0
                case "*":
                    multResult *= num
                    num = 0
                default: num = 10 * num + Int(c.unicodeScalars.first!.value - v1)
                }
            }
            return res + num * multResult
        }
        
        let rightResult = parse()
        
        
        var cache: [String: Set<Int>] = [:]
        let cc = Array(s)
        let limit = answers.max() ?? 0
        
        func computeAll(_ from: Int, _ to: Int) -> Set<Int> {
            let v1 = Unicode.Scalar("0").value
            let cacheKey = String(cc[from ... to])
            if let cc = cache[cacheKey] { return cc }
            var res = Set<Int>()
            var num = 0
            var hasOp = false
            
            for i in from ... to {
                switch cc[i] {
                case "+", "*":
                    hasOp = true
                    let s1 = computeAll(from, i - 1)
                    let s2 = computeAll(i + 1, to)
                    let isMult = cc[i] == "*"
                    for n1 in s1 {
                        for n2 in s2 {
                            let r = isMult ? n1 * n2 : n1 + n2
                            if r <= limit { res.insert(r) }
                        }
                    }
                    
                    if isMult && (s1.isEmpty || s2.isEmpty) && (s1.contains(0) || s2.contains(0)) {
                        res.insert(0)
                    }
                default:
                    if !hasOp {
                        num = 10 * num  + Int(cc[i].unicodeScalars.first!.value - v1)
                    }
                }
            }
        
            if !hasOp { res.insert(num) }
            cache[cacheKey] = res
            return res
        }
        
        let results = computeAll(0, cc.count - 1)
        var score = 0
        for a in answers {
            if a == rightResult {
                score += 5
            } else if results.contains(a) {
                score += 2
            }
        }
        return score
    }
}