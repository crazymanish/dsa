class Solution {
    func isSubsequence(_ s: String, _ t: String) -> Bool {
        let sCount = s.count
        let sArray = Array(s)
        let tArray = Array(t)
        
        var sPointer = 0
        var tPointer = 0
        
        while sPointer < sCount && tPointer < tArray.count {
            let sPointerValue = sArray[sPointer]
            let tPointerValue = tArray[tPointer]
            
            if sPointerValue == tPointerValue { // char match found
                sPointer += 1
                tPointer += 1
            } else { // keep looking, in-case mis-match
                tPointer += 1
            }
        }
        
        return sPointer == sCount
    }
}