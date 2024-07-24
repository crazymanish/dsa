class Solution {
    func sortJumbled(_ mapping: [Int], _ nums: [Int]) -> [Int] {
        // Helper function to map a number based on the provided mapping
        func mappedValue(_ num: Int) -> Int {
            let mappedString = String(num).compactMap { char -> String? in
                if let digit = Int(String(char)) {
                    return String(mapping[digit])
                }
                return nil
            }.joined()
            return Int(mappedString) ?? 0
        }
        
        // Create an array of tuples (original number, mapped value, index)
        let mappedNums = nums.enumerated().map { (index, num) in
            (original: num, mapped: mappedValue(num), index: index)
        }
        
        // Sort based on mapped value, then by original index to maintain relative order
        let sortedMappedNums = mappedNums.sorted {
            if $0.mapped != $1.mapped {
                return $0.mapped < $1.mapped
            } else {
                return $0.index < $1.index
            }
        }
        
        // Extract and return the sorted original numbers
        return sortedMappedNums.map { $0.original }
    }
}