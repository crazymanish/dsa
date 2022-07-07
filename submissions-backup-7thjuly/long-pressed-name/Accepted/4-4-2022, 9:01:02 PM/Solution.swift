// https://leetcode.com/problems/long-pressed-name

class Solution {
    func isLongPressedName(_ name: String, _ typed: String) -> Bool {
        let nameArray = Array(name)
        let typedArray = Array(typed)

        let nameCount = name.count
        let typedCount = typed.count

        var typedPointer = 0

        for namePointer in 0..<nameCount {
            guard typedPointer < typedCount else { return false }

            let namePointerChar = nameArray[namePointer]
            let typedPointerChar = typedArray[typedPointer]

            if namePointerChar != typedPointerChar { return false }

            if namePointer+1 < nameCount && nameArray[namePointer+1] == namePointerChar {
                typedPointer += 1
                continue
            }

            while typedPointer < typedCount && typedArray[typedPointer] == namePointerChar {
                typedPointer += 1
            }
        }

        if typedPointer < typedCount { return false }

        return true
    }
}