class Solution{
    func predictPartyVictory(_ senate: String) -> String {
        var queueR = [Int]()
        var queueD = [Int]()
        let count = senate.count
        
        for (index, char) in senate.enumerated() {
            if char == "R" {
                queueR.append(index)
            } else {
                queueD.append(index)
            }
        }
        
        while !queueR.isEmpty && !queueD.isEmpty {
            let rIndex = queueR.removeFirst()
            let dIndex = queueD.removeFirst()
            
            if rIndex < dIndex {
                queueR.append(rIndex+count)
            } else {
                queueD.append(dIndex+count)
            }
        }
        
        return queueR.isEmpty ? "Dire" : "Radiant"
    }
}