class Solution {
    func computeArea(_ ax1: Int, _ ay1: Int, _ ax2: Int, _ ay2: Int, _ bx1: Int, _ by1: Int, _ bx2: Int, _ by2: Int) -> Int {
        let newLeft = max(ax1, bx1)
        let newRight = min(ax2, bx2)
        let newBottom = max(ay1, by1)
        let newTop = min(ay2, by2)
        
        var overLap = 0
        if newLeft <= newRight && newBottom <= newTop {
            overLap = (newRight-newLeft) * (newTop-newBottom)
        } 
        
        return (ax2-ax1) * (ay2-ay1) + (bx2-bx1) * (by2-by1) - overLap
    }
}