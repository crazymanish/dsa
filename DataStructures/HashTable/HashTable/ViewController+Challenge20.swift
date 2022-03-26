//
//  ViewController+Challenge20.swift
//  HashTable
//
//  Created by Manish Rathi on 26/03/2022.
//

import Foundation
/*
 500. Keyboard Row
 https://leetcode.com/problems/keyboard-row/
 Given an array of strings words, return the words that can be typed using letters of the alphabet on only one row of American keyboard like the image below.
 In the American keyboard:
 the first row consists of the characters "qwertyuiop",
 the second row consists of the characters "asdfghjkl", and
 the third row consists of the characters "zxcvbnm".

 Example 1:
 Input: words = ["Hello","Alaska","Dad","Peace"]
 Output: ["Alaska","Dad"]

 Example 2:
 Input: words = ["omk"]
 Output: []

 Example 3:
 Input: words = ["adsdf","sfd"]
 Output: ["adsdf","sfd"]
 */

extension ViewController {
    func solve20() {
        print("Setting up Challenge20 input!")

        let input = ["Hello","Alaska","Dad","Peace"]
        print("Input: \(input)")
        let output = Solution().findWords(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func findWords(_ words: [String]) -> [String] {
        let hashMap: [Character : Int] = ["q":1,"w":1,"e":1,"r":1,"t":1,"y":1,"u":1,"i":1,"o":1,"p":1,"a":2,"s":2,"d":2,"f":2,"g":2,"h":2,"j":2,"k":2,"l":2,"z":3,"x":3,"c":3,"v":3,"b":3,"n":3,"m":3]

        var outputWords: [String] = []

        for word in words {
            var canTypeUsingOneRow = true
            var initialCharRow: Int? = nil
            for char in word.lowercased() {
                if let expectedRow = initialCharRow {
                    if expectedRow != hashMap[char]! {
                        canTypeUsingOneRow = false
                        break
                    }
                } else {
                    initialCharRow = hashMap[char]
                }
            }

            if canTypeUsingOneRow { outputWords.append(word) }
        }

        return outputWords
    }
}
