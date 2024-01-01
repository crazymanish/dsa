class Solution {
    func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
        let greed = g.sorted()
        let cookie = s.sorted()
        
        var gPointer = 0
        var sPointer = 0
        var content = 0
        while gPointer < greed.count && sPointer < cookie.count {
            let currentGreed = greed[gPointer]
            let currentCookie = cookie[sPointer]
            
            if currentCookie >= currentGreed {
                content = content+1
                gPointer = gPointer+1
                sPointer = sPointer+1
            } else {
                sPointer = sPointer+1
            }
        }
        
        return content   
    }
}