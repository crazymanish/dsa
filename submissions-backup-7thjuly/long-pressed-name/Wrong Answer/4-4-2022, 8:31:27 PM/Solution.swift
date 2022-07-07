// https://leetcode.com/problems/long-pressed-name

class Solution {
    func isLongPressedName(_ name: String, _ typed: String) -> Bool {
        let nameArray = Array(name)
        let typedArray = Array(typed)
        
        let nameCount = name.count
        let typedCount = typed.count
        
        var leftPointer = 0
        var rightPointer = 0
        
        while leftPointer < nameCount && rightPointer < typedCount {
            let leftPointerChar = nameArray[leftPointer]
            let rightPointerChar = typedArray[rightPointer]
            
            if leftPointerChar == rightPointerChar { leftPointer += 1 }
            
            rightPointer += 1
        }
        
        return leftPointer == nameCount && rightPointer == typedCount
    }    
}