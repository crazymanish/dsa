class Solution {
    func numRescueBoats(_ people: [Int], _ limit: Int) -> Int {
        let sortedPeople = people.sorted()
        
        var headPointer = 0
        var tailPointer = people.count - 1
        var rescueBoats = 0

        while headPointer <= tailPointer {
            if sortedPeople[headPointer] + sortedPeople[tailPointer] <= limit {
                headPointer += 1
            }
            
            rescueBoats += 1
            tailPointer -= 1
        }
        
        return rescueBoats 
    }
}