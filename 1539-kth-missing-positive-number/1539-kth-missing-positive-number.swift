class Solution {
    func findKthPositive(_ arr: [Int], _ k: Int) -> Int {
        var kthMissingNumber = 0
        var missingNumberCount = 0
        var arrIndex = 0
        let arrLastIndex = arr.count-1
        
        for number in 1...Int.max {
            if arrIndex <= arrLastIndex && number == arr[arrIndex] {
                arrIndex += 1
            } else {
                missingNumberCount += 1
            }
            
            if missingNumberCount == k { // found the answer
                kthMissingNumber = number
                break 
            } 
        }
        
        return kthMissingNumber
    }
}