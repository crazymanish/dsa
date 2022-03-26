//
//  ViewController+Challenge6.swift
//  HashTable
//
//  Created by Manish Rathi on 26/03/2022.
//

import Foundation
/*
 804. Unique Morse Code Words
 https://leetcode.com/problems/unique-morse-code-words/
 International Morse Code defines a standard encoding where each letter is mapped to a series of dots and dashes, as follows:
 'a' maps to ".-",
 'b' maps to "-...",
 'c' maps to "-.-.", and so on.
 For convenience, the full table for the 26 letters of the English alphabet is given below:
 [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
 Given an array of strings words where each word can be written as a concatenation of the Morse code of each letter.
 For example, "cab" can be written as "-.-..--...", which is the concatenation of "-.-.", ".-", and "-...". We will call such a concatenation the transformation of a word.
 Return the number of different transformations among all words we have.

 Example 1:
 Input: words = ["gin","zen","gig","msg"]
 Output: 2
 Explanation: The transformation of each word is:
 "gin" -> "--...-."
 "zen" -> "--...-."
 "gig" -> "--...--."
 "msg" -> "--...--."
 There are 2 different transformations: "--...-." and "--...--.".

 Example 2:
 Input: words = ["a"]
 Output: 1
 */

extension ViewController {
    func solve6() {
        print("Setting up Challenge6 input!")

        let input = ["gin","zen","gig","msg"]
        print("Input: \(input)")
        let output = Solution().uniqueMorseRepresentations(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func uniqueMorseRepresentations(_ words: [String]) -> Int {
        let morseCodeHashMap = getMorseCodeHashMap()
        var transformationHashMap: [String : Bool] = [:]
        var uniqueTransformationHashMapCount = 0

        for word in words {
            var transformationString = ""
            for character in word {
                transformationString += morseCodeHashMap[character]!
            }

            if transformationHashMap[transformationString] == nil {
                transformationHashMap[transformationString] = true
                uniqueTransformationHashMapCount += 1
            }
        }

        return uniqueTransformationHashMapCount
    }

    private func getMorseCodeHashMap() -> [Character : String] {
        var hashMap: [Character : String] = [:]

        let codes = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
        let alphabets = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

        for index in 0..<26 { hashMap[Character(alphabets[index])] = codes[index] }

        return hashMap
    }
}
