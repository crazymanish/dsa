//
//  ViewController+Challenge47.swift
//  HashTable
//
//  Created by Manish Rathi on 28/03/2022.
//

import Foundation
/*
 599. Minimum Index Sum of Two Lists
 https://leetcode.com/problems/minimum-index-sum-of-two-lists/
 Suppose Andy and Doris want to choose a restaurant for dinner, and they both have a list of favorite restaurants represented by strings.
 You need to help them find out their common interest with the least list index sum. If there is a choice tie between answers, output all of them with no order requirement. You could assume there always exists an answer.

 Example 1:
 Input: list1 = ["Shogun","Tapioca Express","Burger King","KFC"], list2 = ["Piatti","The Grill at Torrey Pines","Hungry Hunter Steakhouse","Shogun"]
 Output: ["Shogun"]
 Explanation: The only restaurant they both like is "Shogun".

 Example 2:
 Input: list1 = ["Shogun","Tapioca Express","Burger King","KFC"], list2 = ["KFC","Shogun","Burger King"]
 Output: ["Shogun"]
 Explanation: The restaurant they both like and have the least index sum is "Shogun" with index sum 1 (0+1).
 */

extension ViewController {
    func solve47() {
        print("Setting up Challenge47 input!")

        let input = ["Shogun","Tapioca Express","Burger King","KFC"]
        print("Input: \(input)")
        let output = Solution().findRestaurant(input, ["Piatti","The Grill at Torrey Pines","Hungry Hunter Steakhouse","Shogun"])
        print("Output: \(output)")
    }
}

private class Solution {
    func findRestaurant(_ list1: [String], _ list2: [String]) -> [String] {
        let hashMapList1 = hashMap(list1)
        let hashMapList2 = hashMap(list2)

        let hashMapRestaurants = findRestaurant(hashMapList1, hashMapList2)

        var minimumKey = Int.max
        for (key, _) in hashMapRestaurants {
             minimumKey = min(minimumKey, key)
        }

        return hashMapRestaurants[minimumKey] ?? []
    }

    private func findRestaurant(
        _ hashMapList1: [String : Int],
        _ hashMapList2: [String : Int]) -> [Int : [String]] {
        var hashMap: [Int : [String]] = [:]

        for (key, value) in hashMapList1 {
            if let value2 = hashMapList2[key] {
                let sum = value + value2
                hashMap[sum] = (hashMap[sum] ?? []) + [key]
            }
        }

        return hashMap
    }

    private func hashMap(_ list: [String]) -> [String : Int] {
        var hashMap: [String : Int] = [:]

        var index = 0
        for text in list {
            hashMap[text] = index

            index += 1
        }

        return hashMap
    }
}
