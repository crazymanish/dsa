//
//  ViewController+Challenge22.swift
//  HashTable
//
//  Created by Manish Rathi on 27/03/2022.
//

import Foundation
/*
 929. Unique Email Addresses
 https://leetcode.com/problems/unique-email-addresses/
 Every valid email consists of a local name and a domain name, separated by the '@' sign. Besides lowercase letters, the email may contain one or more '.' or '+'.
 For example, in "alice@leetcode.com", "alice" is the local name, and "leetcode.com" is the domain name.
 If you add periods '.' between some characters in the local name part of an email address, mail sent there will be forwarded to the same address without dots in the local name. Note that this rule does not apply to domain names.
 For example, "alice.z@leetcode.com" and "alicez@leetcode.com" forward to the same email address.
 If you add a plus '+' in the local name, everything after the first plus sign will be ignored. This allows certain emails to be filtered. Note that this rule does not apply to domain names.
 For example, "m.y+name@email.com" will be forwarded to "my@email.com".
 It is possible to use both of these rules at the same time.
 Given an array of strings emails where we send one email to each emails[i], return the number of different addresses that actually receive mails.

 Example 1:
 Input: emails = ["test.email+alex@leetcode.com","test.e.mail+bob.cathy@leetcode.com","testemail+david@lee.tcode.com"]
 Output: 2
 Explanation: "testemail@leetcode.com" and "testemail@lee.tcode.com" actually receive mails.

 Example 2:
 Input: emails = ["a@leetcode.com","b@leetcode.com","c@leetcode.com"]
 Output: 3
 */

extension ViewController {
    func solve22() {
        print("Setting up Challenge22 input!")

        let input = ["test.email+alex@leetcode.com","test.e.mail+bob.cathy@leetcode.com","testemail+david@lee.tcode.com"]
        print("Input: \(input)")
        let output = Solution().numUniqueEmails(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func numUniqueEmails(_ emails: [String]) -> Int {
        var uniqueEmailsHashMap: [String : Bool] = [:]
        var uniqueEmailsCounter = 0

        for email in emails {
            let emailComponents = email.components(separatedBy: "@")
            var localName = emailComponents[0]
            let domainName = emailComponents[1]

            localName = localName.components(separatedBy: "+")[0]
            localName = localName.replacingOccurrences(of: ".", with: "")

            let forwardedEmail = localName + "@" + domainName

            if uniqueEmailsHashMap[forwardedEmail] == nil {
                uniqueEmailsHashMap[forwardedEmail] = true
                uniqueEmailsCounter += 1
            }
        }

        return uniqueEmailsCounter
    }
}
