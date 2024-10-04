class Solution {
    func dividePlayers(_ skill: [Int]) -> Int {
        // approach:
        // sort first, ascending
        // left right pairing, left ++, rigth --
        //  terminate: does equal to sum of first pair
        //  otherwise: return the sum of chemistry
        //                  - Product of the sum in group
        // skill.length is guaranteed to be >=2
        var skill = skill.sorted(by: <)
        var left = 0
        var right = skill.count - 1
        var sumChemistry = 0
        var equalSkill = skill[left] + skill[right]
        
        while left < right {
            let sum = skill[left] + skill[right]
            let product = skill[left] * skill[right]
            if sum != equalSkill {
                return -1
            }
            
            sumChemistry += product
            left = left + 1
            right = right - 1
        }
        
        return sumChemistry
    }
}