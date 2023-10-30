class Solution {
    func sortByBits(_ arr: [Int]) -> [Int] {
        var dictionary: Dictionary<Int, [Int]> = [:]
        var result: [Int] = []
        
        for num in arr {
            let key = String(num, radix: 2).filter({$0 == "1"}).count
            dictionary[key , default: []].append(num)
            dictionary[key]
        }
        
        let keys = dictionary.keys.sorted()
        for key in keys {
            result += dictionary[key]!.sorted()
        }
        
        return result
    }
}