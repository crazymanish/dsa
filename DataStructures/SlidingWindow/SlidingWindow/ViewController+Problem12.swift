//
//  ViewController+Problem12.swift
//  SlidingWindow
//
//  Created by Manish Rathi on 20/03/2022.
//

import Foundation
/*
 2024. Maximize the Confusion of an Exam
 https://leetcode.com/problems/maximize-the-confusion-of-an-exam/
 Note: Duplicate of with T/F https://leetcode.com/problems/max-consecutive-ones-iii/

 A teacher is writing a test with n true/false questions, with 'T' denoting true and 'F' denoting false. He wants to confuse the students by maximizing the number of consecutive questions with the same answer (multiple trues or multiple falses in a row).
 You are given a string answerKey, where answerKey[i] is the original answer to the ith question. In addition, you are given an integer k, the maximum number of times you may perform the following operation:

 Change the answer key for any question to 'T' or 'F' (i.e., set answerKey[i] to 'T' or 'F').
 Return the maximum number of consecutive 'T's or 'F's in the answer key after performing the operation at most k times.

 Example 1:
 Input: answerKey = "TTFF", k = 2
 Output: 4
 Explanation: We can replace both the 'F's with 'T's to make answerKey = "TTTT".
 There are four consecutive 'T's.

 Example 2:
 Input: answerKey = "TFFT", k = 1
 Output: 3
 Explanation: We can replace the first 'T' with an 'F' to make answerKey = "FFFT".
 Alternatively, we can replace the second 'T' with an 'F' to make answerKey = "TFFF".
 In both cases, there are three consecutive 'F's.

 Example 3:
 Input: answerKey = "TTFTTFTT", k = 1
 Output: 5
 Explanation: We can replace the first 'F' to make answerKey = "TTTTTFTT"
 Alternatively, we can replace the second 'F' to make answerKey = "TTFTTTTT".
 In both cases, there are five consecutive 'T's.
 */

extension ViewController {
    func solve12() {
        print("Setting up Problem12 input!")

        var input = "TTFF"
        print("Input1: \(input)")
        var output = Solution().maxConsecutiveAnswers(input, 2)
        print("Output1: \(output)")

        input = "TFFT"
        print("Input2: \(input)")
        output = Solution().maxConsecutiveAnswers(input, 1)
        print("Output2: \(output)")

        input = "TTFTTFTT"
        print("Input3: \(input)")
        output = Solution().maxConsecutiveAnswers(input, 1)
        print("Output3: \(output)")
    }
}

fileprivate class Solution {
    private var slidingWindow: SlidingWindow<String>!
    private var flipPossibleCount: Int!
    private var currentWindowConsecutiveOnes = 0
    private var maximumConsecutiveOnes = Int.min

    private var slidingWindowFirstValue: String { String(slidingWindow.startIndexValue) }
    private var slidingWindowLastValue: String { String(slidingWindow.endIndexValue) }

    func maxConsecutiveAnswers(_ answerKey: String, _ k: Int) -> Int {
        let maximumConsecutiveOnesWithT = longestOnes(answerKey, k, "T")
        let maximumConsecutiveOnesWithF = longestOnes(answerKey, k, "F")

        return max(maximumConsecutiveOnesWithT, maximumConsecutiveOnesWithF)
    }

    private func longestOnes(_ answerKey: String, _ k: Int, _ answerKeyType: String) -> Int {
        slidingWindow = SlidingWindow(answerKey)
        flipPossibleCount = k
        let inputNumsCount = answerKey.count
        currentWindowConsecutiveOnes = 0
        maximumConsecutiveOnes = Int.min

        while slidingWindow.endIndex < inputNumsCount {
            if slidingWindowLastValue == answerKeyType {
                handleWhenValueIsOne()
            } else {
                let type = answerKeyType == "T" ? "F" : "T"
                handleWhenValueIsZero(type)
            }
        }

        maximumConsecutiveOnes = max(maximumConsecutiveOnes, currentWindowConsecutiveOnes)

        return maximumConsecutiveOnes
    }

    // if sliding value is coming as 1, don't do anything just increment the ConsecutiveOnes
    private func handleWhenValueIsOne() {
        currentWindowConsecutiveOnes += 1
        slidingWindow.endIndex += 1 // Slide window by one from end.
    }

    private func handleWhenValueIsZero(_ answerKeyType: String) {
        // lets see if have chance to make 0 into 1 first using K(flipPossibleCount) value
        if flipPossibleCount > 0 {
            flipPossibleCount -= 1
            currentWindowConsecutiveOnes += 1
            slidingWindow.endIndex += 1 // Slide window by one from end.
        } else if flipPossibleCount == 0 {
            // We found maximum ConsecutiveOnes in this sliding-window
            maximumConsecutiveOnes = max(maximumConsecutiveOnes, currentWindowConsecutiveOnes)

            // Adjust currentWindowConsecutiveOnes, before sliding next window
            currentWindowConsecutiveOnes -= 1

            if slidingWindowFirstValue == answerKeyType {
                flipPossibleCount += 1
            }

            slidingWindow.startIndex += 1 // Slide window by one from start.
        }
    }
}
