class Solution {
    func mirrorReflection(_ p: Int, _ q: Int) -> Int {
        var mutableP = p
        var mutableQ = q
        
        while mutableP % 2 == 0 && mutableQ % 2 == 0 {
            mutableP /= 2
            mutableQ /= 2
        }
        
        if mutableP % 2 == 0 { return 2 }
        if mutableQ % 2 == 0 { return 0 }
        
        return 1
    }
}