class Solution {
    func hasGroupsSizeX(_ deck: [Int]) -> Bool {
        var hashMap: [Int : Int] = [:]
        
        for card in deck {
            let hashMapValue = hashMap[card] ?? 0
            hashMap[card] = hashMapValue + 1
        }
        
        var gcdValue = 0
        for (_, value) in hashMap {
            gcdValue = gcd(gcdValue, value)
        }
        
        return gcdValue > 1
    }
    
    private func gcd(_ x: Int, _ y: Int) -> Int {
        return y > 0 ? gcd(y, x % y) : x
    }
}