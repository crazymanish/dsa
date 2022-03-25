//
//  ViewController+Challenge3.swift
//  HashTable
//
//  Created by Manish Rathi on 25/03/2022.
//

import Foundation
/*
 1365. How Many Numbers Are Smaller Than the Current Number
 https://leetcode.com/problems/how-many-numbers-are-smaller-than-the-current-number/
 Given the array nums, for each nums[i] find out how many numbers in the array are smaller than it. That is, for each nums[i] you have to count the number of valid j's such that j != i and nums[j] < nums[i].
 Return the answer in an array.

 Example 1:
 Input: nums = [8,1,2,2,3]
 Output: [4,0,1,1,3]
 Explanation:
 For nums[0]=8 there exist four smaller numbers than it (1, 2, 2 and 3).
 For nums[1]=1 does not exist any smaller number than it.
 For nums[2]=2 there exist one smaller number than it (1).
 For nums[3]=2 there exist one smaller number than it (1).
 For nums[4]=3 there exist three smaller numbers than it (1, 2 and 2).

 Example 2:
 Input: nums = [6,5,4,8]
 Output: [2,1,0,3]

 Example 3:
 Input: nums = [7,7,7,7]
 Output: [0,0,0,0]
 */

extension ViewController {
    func solve3() {
        print("Setting up Challenge3 input!")

        let input = [8,1,2,2,3]
        print("Input: \(input)")
        let output = Solution().smallerNumbersThanCurrent(input)
        print("Output: \(output)")
    }
}

private class Solution {
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
