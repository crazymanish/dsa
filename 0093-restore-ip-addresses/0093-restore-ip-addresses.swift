class Solution {
    func restoreIpAddresses(_ s: String) -> [String] {
        let s = Array(s)
        let sCount = s.count
        var ipAddresses = [String]()
        
        func backtracking(_ currentIndex: Int, _ ipAddressPartCount: Int, _ partialIpAddress: String) {
            // ipAddressPartCount == 3 means, we might have the valid iPaddress now after adding remaining 4th part digits
            if ipAddressPartCount == 3 && currentIndex < sCount {
                let remainingDigitsValue = Int(String(s[currentIndex...]))!
                
                if 0 <= remainingDigitsValue && remainingDigitsValue <= 255 { 
                    let ipAddress = partialIpAddress + "\(remainingDigitsValue)"
                    
                    // -3 for 3 dots "."
                    if sCount == ipAddress.count-3 { ipAddresses.append(ipAddress) }
                }
                return
            }
            
            var currentDigitsValue = 0
            for index in currentIndex..<sCount {
                currentDigitsValue = (currentDigitsValue * 10) + Int("\(s[index])")!
                
                if 0 <= currentDigitsValue && currentDigitsValue <= 255 {
                    backtracking(index + 1, ipAddressPartCount + 1, partialIpAddress + "\(currentDigitsValue).")
                }
            }
        }

        backtracking(0, 0, "")
        return ipAddresses
    }
}