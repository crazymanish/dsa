class Solution {
    func bestTeamScore(_ scores: [Int], _ ages: [Int]) -> Int {
        let agesAndScoresSorted: [(age: Int, score: Int)] = zip(ages, scores)
            .sorted(by: { 
                $0.0 == $1.0 ? $0.1 < $1.1 : $0.0 < $1.0 
            })
    
        var dpCache = agesAndScoresSorted.map { $0.score }
        
        for i in 1..<scores.count {
            for j in 0...(i - 1) {
                if agesAndScoresSorted[i].score >= agesAndScoresSorted[j].score {
                    dpCache[i] = max(dpCache[i], agesAndScoresSorted[i].score + dpCache[j])
                }
            }
        }

        return dpCache.max()!
    }
}