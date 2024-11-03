class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var hashMap: [Int : Int] = [:] // Num : Index
        
        for (index, num) in nums.enumerated() {
            let reminder = target - num
            
            if let reminderIndex = hashMap[reminder] {
                return [reminderIndex, index] // Found answer
            } else {
                hashMap[num] = index
            }
        }
        
        return []
    }
}