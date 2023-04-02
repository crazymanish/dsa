class Solution {
    func successfulPairs(_ spells: [Int], _ potions: [Int], _ success: Int) -> [Int] {
        var successfulPairs = [Int]()
        let potions = potions.sorted()

        func binarySearch(_ spell: Int) {
            var left = 0
            var right = potions.count - 1
        
            while left <= right {
                let middle = (left + right) / 2 
            
                if potions[middle] * spell >= success {
                    right = middle - 1
                } else if potions[middle] * spell < success {
                    left = middle + 1
                } 
            }
            
            successfulPairs.append(potions.count - left)
        }

        for spell in spells { 
            binarySearch(spell)
        }
        
        return successfulPairs
    }
}