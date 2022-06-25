class Solution {
    func smallerNumbersThanCurrent(_ nums: [Int]) -> [Int] {
        let sortedNums = nums.sorted()
        
        var hashMap: [Int : Int] = [:]
        
        var previousIndexValue = -1
        for currentIndex in 0..<sortedNums.count {
            let currentIndexValue = sortedNums[currentIndex]
            var smallerNumbers = currentIndex
            
            if currentIndexValue == previousIndexValue { smallerNumbers = hashMap[currentIndexValue]! }
            
            hashMap[currentIndexValue] = smallerNumbers
            previousIndexValue = currentIndexValue
        }
        
        var output: [Int] = []
        for num in nums {
            output.append(hashMap[num]!)
        }
        
        return output
    }
}