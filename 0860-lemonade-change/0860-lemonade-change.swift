class Solution {
    func lemonadeChange(_ bills: [Int]) -> Bool {
        var fives = 0
        var tens = 0
        
        for bill in bills {
            switch bill {
            case 5:
                fives += 1
            case 10:
                fives -= 1
                tens += 1
            case 20:
                if tens > 0 {
                    tens -= 1
                    fives -= 1
                } else {
                    fives -= 3
                }
            default:
                return false
            }
            
            guard min(fives, tens) >= 0 else { return false }
        }
        
        return true
    }
}