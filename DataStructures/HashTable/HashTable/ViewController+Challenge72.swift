//
//  ViewController+Challenge72.swift
//  HashTable
//
//  Created by Manish Rathi on 01/04/2022.
//

import Foundation
/*
 811. Subdomain Visit Count
 https://leetcode.com/problems/subdomain-visit-count/
 A website domain "discuss.leetcode.com" consists of various subdomains. At the top level, we have "com", at the next level, we have "leetcode.com" and at the lowest level, "discuss.leetcode.com". When we visit a domain like "discuss.leetcode.com", we will also visit the parent domains "leetcode.com" and "com" implicitly.
 A count-paired domain is a domain that has one of the two formats "rep d1.d2.d3" or "rep d1.d2" where rep is the number of visits to the domain and d1.d2.d3 is the domain itself.
 For example, "9001 discuss.leetcode.com" is a count-paired domain that indicates that discuss.leetcode.com was visited 9001 times.
 Given an array of count-paired domains cpdomains, return an array of the count-paired domains of each subdomain in the input. You may return the answer in any order.

 Example 1:
 Input: cpdomains = ["9001 discuss.leetcode.com"]
 Output: ["9001 leetcode.com","9001 discuss.leetcode.com","9001 com"]
 Explanation: We only have one website domain: "discuss.leetcode.com".
 As discussed above, the subdomain "leetcode.com" and "com" will also be visited. So they will all be visited 9001 times.

 Example 2:
 Input: cpdomains = ["900 google.mail.com", "50 yahoo.com", "1 intel.mail.com", "5 wiki.org"]
 Output: ["901 mail.com","50 yahoo.com","900 google.mail.com","5 wiki.org","5 org","1 intel.mail.com","951 com"]
 Explanation: We will visit "google.mail.com" 900 times, "yahoo.com" 50 times, "intel.mail.com" once and "wiki.org" 5 times.
 For the subdomains, we will visit "mail.com" 900 + 1 = 901 times, "com" 900 + 50 + 1 = 951 times, and "org" 5 times.
 */

extension ViewController {
    func solve72() {
        print("Setting up Challenge72 input!")

        let input = ["900 google.mail.com", "50 yahoo.com", "1 intel.mail.com", "5 wiki.org"]
        print("Input: \(input)")
        let output = Solution().subdomainVisits(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func subdomainVisits(_ cpdomains: [String]) -> [String] {
        var hashMap: [String : Int] = [:]

        for cpdomain in cpdomains {
            let cpdomainComponents = cpdomain.components(separatedBy: " ")
            let visitedTimes = Int(cpdomainComponents[0])!
            let domain = cpdomainComponents[1]
            let subdomains = domain.components(separatedBy: ".")
            let subdomainsCount = subdomains.count

            for index in 0..<subdomainsCount {
                var currentIndex = index
                var subdomain = ""

                while currentIndex < subdomainsCount {
                    subdomain += "\(subdomains[currentIndex])."
                    currentIndex += 1
                }

                subdomain.removeLast() // extra dot

                let hashMapValue = hashMap[subdomain] ?? 0
                hashMap[subdomain] = hashMapValue + visitedTimes
            }
        }

        var output: [String] = []
        for (key, value) in hashMap {
            output.append("\(value) \(key)")
        }

        return output
    }
}
