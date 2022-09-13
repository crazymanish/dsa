class Solution {
    func validUtf8(_ data: [Int]) -> Bool {
        var pending = 0
        
        for byte in data {
            if byte & 128 == 0 {   // single byte char
                if pending > 0 { return false }
                continue
            }
            
            if byte & 64 == 0 {    // pending byte
                pending -= 1
                if pending < 0 { return false }
                continue
            }
            
            // new sequence
            if pending > 0 { return false }
            
            pending = 1
            if byte & 32 == 0 { continue }
            
            pending += 1
            if byte & 16 == 0 { continue }
            
            pending += 1
            if byte & 8 != 0 { return false }  // missing 0 bit after the ones
        }
        
        return pending == 0
    }
}