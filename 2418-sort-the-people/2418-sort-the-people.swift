class Solution {
    func sortPeople(_ names: [String], _ heights: [Int]) -> [String] {
        var people = [(name: String, height: Int)]()
        for i in 0..<names.count {
            people.append((names[i], heights[i]))
        }
        
        people.sort(by: { $0.height > $1.height })
        
        var result = [String]()
        for person in people {
            result.append(person.name)
        }
        
        return result
    }
}