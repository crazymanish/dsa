class Solution {
    func equationsPossible(_ equations: [String]) -> Bool {
        var p = Array(repeating: 0, count: 26)
        for i in 0...25 {
            p[i] = i
        }
        
        func find(_ x: Int) -> Int {
            if p[x] == x { return x }
            p[x] = find(p[x])
            return p[x]
        }
        
        func unite(_ x: Int, _ y: Int) {
            let rx = find(x)
            let ry = find(y)
            if rx == ry { return }
            p[rx] = ry
        }
        
        for s in equations {
            var s = Array(s)
            let x = Int(s[0].asciiValue! - Character("a").asciiValue!)
            let y = Int(s[3].asciiValue! - Character("a").asciiValue!)
            if s[1] == "=" {
                unite(x,y)
            }
        }
        
        for s in equations {
            var s = Array(s)
            let x = Int(s[0].asciiValue! - Character("a").asciiValue!)
            let y = Int(s[3].asciiValue! - Character("a").asciiValue!)
            if s[1] == "!" {
                let rx = find(x)
                let ry = find(y)
                if rx == ry { return false }
            }
        }
        
        return true
    }
}