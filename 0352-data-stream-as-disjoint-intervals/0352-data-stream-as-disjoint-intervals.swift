class SummaryRanges {
    private var ranges: [ClosedRange<Int>]

    init() {
        ranges = [ClosedRange<Int>]()
    }
    
    func addNum(_ value: Int) {
        
        for i in 0..<ranges.count {
            if ranges[i].lowerBound - 1 == value {
                ranges[i] = value...ranges[i].upperBound
                return
            } else if ranges[i].upperBound + 1 == value {
                if i + 1 < ranges.count, ranges[i + 1].lowerBound - 1 == value {
                    ranges[i] = ranges[i].lowerBound...ranges[i + 1].upperBound
                    ranges.remove(at: i + 1)
                } else {
                    ranges[i] = ranges[i].lowerBound...value
                }
                return
            } else if ranges[i].contains(value) {
                return
            }
        }
        ranges.append(value...value)
        ranges = ranges.sorted(by: { $0.lowerBound < $1.lowerBound })
    }
    
    func getIntervals() -> [[Int]] {
        ranges.map({ [$0.lowerBound, $0.upperBound]})
    }
}

/**
 * Your SummaryRanges object will be instantiated and called as such:
 * let obj = SummaryRanges()
 * obj.addNum(value)
 * let ret_2: [[Int]] = obj.getIntervals()
 */