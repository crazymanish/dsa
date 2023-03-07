class Solution {
    func minimumTime(_ time: [Int], _ totalTrips: Int) -> Int {
        var low = time.min()! 
        var high = time.max()! * totalTrips 
        
        while low<high {
            let mid = (low+high)/2
            let midTrips = time.reduce(0){$0 + mid/$1}
            
            if totalTrips <= midTrips {
                high = mid
            } else {
                low = mid + 1
            }
        }
        
        return low
    }
}