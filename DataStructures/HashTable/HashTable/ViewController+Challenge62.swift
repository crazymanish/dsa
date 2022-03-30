//
//  ViewController+Challenge62.swift
//  HashTable
//
//  Created by Manish Rathi on 30/03/2022.
//

import Foundation
/*
 914. X of a Kind in a Deck of Cards
 https://leetcode.com/problems/x-of-a-kind-in-a-deck-of-cards/
 In a deck of cards, each card has an integer written on it.
 Return true if and only if you can choose X >= 2 such that it is possible to split the entire deck into 1 or more groups of cards, where:
 Each group has exactly X cards.
 All the cards in each group have the same integer.

 Example 1:
 Input: deck = [1,2,3,4,4,3,2,1]
 Output: true
 Explanation: Possible partition [1,1],[2,2],[3,3],[4,4].

 Example 2:
 Input: deck = [1,1,1,2,2,2,3,3]
 Output: false
 Explanation: No possible partition.
 */

extension ViewController {
    func solve62() {
        print("Setting up Challenge62 input!")

        let input = [1,2,3,4,4,3,2,1]
        print("Input: \(input)")
        let output = Solution().hasGroupsSizeX(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func hasGroupsSizeX(_ deck: [Int]) -> Bool {
        var hashMap: [Int : Int] = [:]

        for card in deck {
            let hashMapValue = hashMap[card] ?? 0
            hashMap[card] = hashMapValue + 1
        }

        var gcdValue = 0
        for (_, value) in hashMap {
            gcdValue = gcd(gcdValue, value)
        }

        return gcdValue > 1
    }

    private func gcd(_ x: Int, _ y: Int) -> Int {
        return y > 0 ? gcd(y, x % y) : x
    }
}
