// https://leetcode.com/problems/number-of-provinces

class Solution {
    func findCircleNum(_ isConnected: [[Int]]) -> Int {
        let citiesCount = isConnected.count
        var visitedCities = Array(repeating: false, count: citiesCount)
        var numberOfProvinces = 0
        
        func visitCityUsingDFS(_ index: Int) {
            if visitedCities[index] { return } // Exit, if already visit city
            visitedCities[index] = true
            
            let cityInfo = isConnected[index]
            for cityIndex in index+1..<cityInfo.count {
                let isConnected = cityInfo[cityIndex] == 1
                if isConnected { visitCityUsingDFS(cityIndex) }
            }
        }
        
        for index in 0..<isConnected.count {
            if visitedCities[index] == false {
                visitCityUsingDFS(index)
                numberOfProvinces += 1
            }
        }
        
        return numberOfProvinces
    }
}