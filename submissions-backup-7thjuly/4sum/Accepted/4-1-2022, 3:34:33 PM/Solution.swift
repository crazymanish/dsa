// https://leetcode.com/problems/4sum

class Solution {    
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        var output: [[Int]] = []
        let array = nums.sorted()
        let arrayCount = array.count

        guard arrayCount > 3 else { return output }

        for firstNumIndex in 0..<arrayCount - 3 {
            if firstNumIndex > 0, array[firstNumIndex] == array[firstNumIndex-1] { continue } // skip Duplicate
            
            for secondNumIndex in firstNumIndex+1..<arrayCount - 2 {
                if secondNumIndex-1 > firstNumIndex, array[secondNumIndex] == array[secondNumIndex-1] { continue } // skip Duplicate
                
                var leftPointer = secondNumIndex + 1
                var rightPointer = arrayCount - 1

                while leftPointer < rightPointer {
                    let firstNum = array[firstNumIndex]
                    let secondNum = array[secondNumIndex]
                    let thirdNum = array[leftPointer]
                    let forthNum = array[rightPointer]
                
                    let currentTarget = firstNum + secondNum + thirdNum + forthNum
                    if (currentTarget == target) {
                        output.append([firstNum, secondNum, thirdNum, forthNum])
                        leftPointer += 1
                        
                        while leftPointer < rightPointer && array[leftPointer] == array[leftPointer-1] {
                            leftPointer += 1
                        }
                    } else if (currentTarget < target) {
                        leftPointer += 1
                    } else {
                        rightPointer -= 1
                    }
                }
            }
        }

        return output
    }
}