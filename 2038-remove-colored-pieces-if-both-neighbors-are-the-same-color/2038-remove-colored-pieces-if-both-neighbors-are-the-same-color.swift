class Solution {
    func winnerOfGame(_ colors: String) -> Bool {
        var alice = 0
        var bob = 0
        var colorsArray = Array(colors)

        if colorsArray.count > 1 {
            for i in 1..<colorsArray.count-1 {
                if colorsArray[i] == colorsArray[i-1] && colorsArray[i] == colorsArray[i+1] {
                    if colorsArray[i] == "A" {
                        alice += 1
                    } else {
                        bob += 1
                    }
                }
            }
        }
        
        return alice-bob >= 1
    }
}