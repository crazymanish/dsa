class Solution {
    func findMaximizedCapital(_ k: Int, _ w: Int, _ profits: [Int], _ capital: [Int]) -> Int {
        var w = w
        var k = k 
        var profitsCapital = [(Int,Int)]()
        
        for (p, c) in zip(profits, capital) {
            profitsCapital.append((p,c))
        }
        
        profitsCapital.sort(by: { $0.0 > $1.0 })
        
        var i = 0 
        while k != 0 && profitsCapital.count > 0 && i < profitsCapital.count {
            let project = profitsCapital[i]
            let profitForProject = project.0
            let capitalForProject = project.1
            
            if  project.1 <= w {
                profitsCapital.remove(at: i)
                i = 0
                w += project.0
                k -= 1
            } else {
                i += 1
            }
        }
        
        return w
    }
}