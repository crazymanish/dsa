class Solution {
    func movesToStamp(_ stamp: String, _ target: String) -> [Int] {
        let stamp = Array(stamp), cs = stamp.count, ct = target.count
        var target = Array(target), result = [Int](), found = true
        
        while found {
            found = false
            
            fori: for i in 0...(ct - cs) {
                var wildcards = 0
                
                for j in 0..<cs {
                    if target[i + j] == "*" { // wildcard
                        wildcards += 1
                    } else if target[i + j] != stamp[j] {
                        continue fori
                    }
                }
                
                if wildcards < cs { // at least one letter is not wildcard
                    found = true
                    result.append(i)
                    for j in 0..<cs { target[i + j] = "*" }
                }
            }
        }
        
        return target.reduce(into: Bool(false), { $0 = $0 || $1 != "*" }) ? [] : result.reversed()
    }
}