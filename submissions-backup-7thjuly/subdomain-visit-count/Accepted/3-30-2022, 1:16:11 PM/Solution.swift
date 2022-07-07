// https://leetcode.com/problems/subdomain-visit-count

class Solution {
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