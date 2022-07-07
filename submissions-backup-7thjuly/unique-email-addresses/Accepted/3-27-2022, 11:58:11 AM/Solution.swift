// https://leetcode.com/problems/unique-email-addresses

class Solution {
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