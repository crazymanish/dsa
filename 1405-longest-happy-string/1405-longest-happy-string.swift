class Solution {
    func longestDiverseString(_ a: Int, _ b: Int, _ c: Int) -> String {
        var counts: [Character:Int] = ["a":a, "b":b, "c":c]
        var result = ""

        while true {
            // select letter with largest remaining count
            var tuple = counts.max{a,b in a.value < b.value}!
            
            // if selected letter will result in a triplet, set `tuple` to second-largest letter count
            if [tuple.key, tuple.key] == result.suffix(2) {
                tuple = counts.filter{a in a.key != tuple.key}.max{a,b in a.value < b.value}!
            }
            
            guard tuple.value > 0 else { return result }
            
            result.append(tuple.key)
            counts[tuple.key]! -= 1
        }
    }
}