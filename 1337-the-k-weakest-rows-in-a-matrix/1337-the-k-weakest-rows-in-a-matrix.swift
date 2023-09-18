class Solution {
    func kWeakestRows(_ mat: [[Int]], _ k: Int) -> [Int] {
        var rowsStrength = mat.enumerated().reduce([], { result, value in
            result + [(value.element.reduce(0, +), value.offset)]
        }).sorted(by: { $0.0 < $1.0 || $0.1 < $1.1 })

        var output = [Int]()
        for rowStrength in rowsStrength {
            if output.count == k { break }
            
            output.append(rowStrength.1)
        }
        
        return output
    }
}