class Solution {
    func destCity(_ paths: [[String]]) -> String {
        var hashMap: [String : String] = [:]
        
        for path in paths { hashMap[path[0]] = path[1] }
        
        var outputDestinationCity = ""
        for path in paths {
            let currentDestinationCity = path[1]
            if hashMap[currentDestinationCity] == nil {
                outputDestinationCity = currentDestinationCity
                break
            }
        }
        
        return outputDestinationCity
    }
}