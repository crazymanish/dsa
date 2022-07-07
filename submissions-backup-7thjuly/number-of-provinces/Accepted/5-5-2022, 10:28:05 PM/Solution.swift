// https://leetcode.com/problems/number-of-provinces

class Solution {
    func findCircleNum(_ isConnected: [[Int]]) -> Int {
        let citiesCount = isConnected.count
        var visitedCities = Array(repeating: false, count: citiesCount)
        var numberOfProvinces = 0
        
        func visitCityUsingDFS(_ startingCityIndex: Int) {
            visitedCities[startingCityIndex] = true
            
            for currentCityIndex in 0..<citiesCount {
                if startingCityIndex == currentCityIndex { continue }
                
                let isBothCitiesConnected = isConnected[startingCityIndex][currentCityIndex] == 1
                if isBothCitiesConnected && visitedCities[currentCityIndex] == false {
                    visitCityUsingDFS(currentCityIndex)
                }
            }
        }
        
        for startingCityIndex in 0..<citiesCount {
            if visitedCities[startingCityIndex] == false {
                visitCityUsingDFS(startingCityIndex)
                numberOfProvinces += 1
            }
        }
        
        return numberOfProvinces
    }
}