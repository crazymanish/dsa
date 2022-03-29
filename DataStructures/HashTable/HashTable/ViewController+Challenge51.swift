//
//  ViewController+Challenge51.swift
//  HashTable
//
//  Created by Manish Rathi on 29/03/2022.
//

import Foundation
/*
 997. Find the Town Judge
 https://leetcode.com/problems/find-the-town-judge/
 In a town, there are n people labeled from 1 to n. There is a rumor that one of these people is secretly the town judge.
 If the town judge exists, then:

 The town judge trusts nobody.
 Everybody (except for the town judge) trusts the town judge.
 There is exactly one person that satisfies properties 1 and 2.
 You are given an array trust where trust[i] = [ai, bi] representing that the person labeled ai trusts the person labeled bi.

 Return the label of the town judge if the town judge exists and can be identified, or return -1 otherwise.

 Example 1:
 Input: n = 2, trust = [[1,2]]
 Output: 2

 Example 2:
 Input: n = 3, trust = [[1,3],[2,3]]
 Output: 3

 Example 3:
 Input: n = 3, trust = [[1,3],[2,3],[3,1]]
 Output: -1
 */

extension ViewController {
    func solve51() {
        print("Setting up Challenge51 input!")

        let input = [[1,3],[2,3]]
        print("Input: \(input)")
        let output = Solution().findJudge(3, input)
        print("Output: \(output)")
    }
}

private class Solution {
    func findJudge(_ n: Int, _ trusts: [[Int]]) -> Int {
        var hashMap: [Int : [Int]] = [:]

        for people in 1...n { hashMap[people] = [] }

        for trust in trusts {
            hashMap[trust[0]] = (hashMap[trust[0]] ?? []) + [trust[1]]
        }

        var possibleJudge = -1
        for (key, value) in hashMap {
            if value.isEmpty {
                possibleJudge = key
                break
            }
        }

        if possibleJudge != -1 {
            for (key, value) in hashMap {
                if key == possibleJudge { continue }

                if value.contains(possibleJudge) == false {
                    possibleJudge = -1
                    break
                }
            }
        }

        return possibleJudge
    }
}
