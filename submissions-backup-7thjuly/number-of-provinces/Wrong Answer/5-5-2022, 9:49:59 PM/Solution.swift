// https://leetcode.com/problems/number-of-provinces

class Solution {
    func findCircleNum(_ isConnected: [[Int]]) -> Int {
        var numberOfProvinces = isConnected.count
        
        func findProvincesUsingDFS(_ index: Int) {
            let cityInfo = isConnected[index]
            
            for cityIndex in index+1..<cityInfo.count {
                let isConnected = cityInfo[cityIndex] == 1
                if isConnected { numberOfProvinces -= 1 }
            }
        }
        
        for index in 0..<isConnected.count {
            findProvincesUsingDFS(index)
        }
        
        return numberOfProvinces
    }
}