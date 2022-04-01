//
//  ViewController+Challenge67.swift
//  HashTable
//
//  Created by Manish Rathi on 01/04/2022.
//

import Foundation
/*
 1817. Finding the Users Active Minutes
 https://leetcode.com/problems/finding-the-users-active-minutes/
 You are given the logs for users' actions on LeetCode, and an integer k. The logs are represented by a 2D integer array logs where each logs[i] = [IDi, timei] indicates that the user with IDi performed an action at the minute timei.
 Multiple users can perform actions simultaneously, and a single user can perform multiple actions in the same minute.
 The user active minutes (UAM) for a given user is defined as the number of unique minutes in which the user performed an action on LeetCode. A minute can only be counted once, even if multiple actions occur during it.
 You are to calculate a 1-indexed array answer of size k such that, for each j (1 <= j <= k), answer[j] is the number of users whose UAM equals j.
 Return the array answer as described above.

 Example 1:
 Input: logs = [[0,5],[1,2],[0,2],[0,5],[1,3]], k = 5
 Output: [0,2,0,0,0]
 Explanation:
 The user with ID=0 performed actions at minutes 5, 2, and 5 again. Hence, they have a UAM of 2 (minute 5 is only counted once).
 The user with ID=1 performed actions at minutes 2 and 3. Hence, they have a UAM of 2.
 Since both users have a UAM of 2, answer[2] is 2, and the remaining answer[j] values are 0.

 Example 2:
 Input: logs = [[1,1],[2,2],[2,3]], k = 4
 Output: [1,1,0,0]
 Explanation:
 The user with ID=1 performed a single action at minute 1. Hence, they have a UAM of 1.
 The user with ID=2 performed actions at minutes 2 and 3. Hence, they have a UAM of 2.
 There is one user with a UAM of 1 and one with a UAM of 2.
 Hence, answer[1] = 1, answer[2] = 1, and the remaining values are 0.
 */

extension ViewController {
    func solve67() {
        print("Setting up Challenge67 input!")

        let input = [[0,5],[1,2],[0,2],[0,5],[1,3]]
        print("Input: \(input)")
        let output = Solution().findingUsersActiveMinutes(input, 5)
        print("Output: \(output)")
    }
}

private class Solution {
    func findingUsersActiveMinutes(_ logs: [[Int]], _ k: Int) -> [Int] {
        var hashMap: [Int : Set<Int>] = [:]

        for log in logs {
            let id = log[0]

            var set = hashMap[id] ?? Set<Int>()
            set.insert(log[1])

            hashMap[id] = set
        }

        var output: [Int] = []
        for _ in 0..<k { output.append(0) }

        for (_, value) in hashMap {
            if value.count <= k {
                let index = value.count - 1
                let existingValue = output[index]

                output[index] = existingValue + 1
            }
        }

        return output
    }
}
