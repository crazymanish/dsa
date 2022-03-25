//
//  ViewController+Challenge2.swift
//  HashTable
//
//  Created by Manish Rathi on 25/03/2022.
//

import Foundation
/*
 771. Jewels and Stones
 https://leetcode.com/problems/jewels-and-stones/
 You're given strings jewels representing the types of stones that are jewels, and stones representing the stones you have. Each character in stones is a type of stone you have. You want to know how many of the stones you have are also jewels.
 Letters are case sensitive, so "a" is considered a different type of stone from "A".

 Example 1:
 Input: jewels = "aA", stones = "aAAbbbb"
 Output: 3

 Example 2:
 Input: jewels = "z", stones = "ZZ"
 Output: 0
 */

extension ViewController {
    func solve2() {
        print("Setting up Challenge2 input!")

        let output = Solution().numJewelsInStones("aA", "aAAbbbb")
        print("Output: \(output)")
    }
}

private class Solution {
    func numJewelsInStones(_ jewels: String, _ stones: String) -> Int {
        typealias CharIsExistMap = [Character : Bool]
        var hashMap: CharIsExistMap = [:]

        for jewel in jewels {
            hashMap[jewel] = true
        }

        var output = 0
        for stone in stones {
            if hashMap[stone] != nil { output += 1 }
        }

        return output
    }
}
