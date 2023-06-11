class SnapshotArray {
    typealias VarData = (snapId: Int, value: Int)
    var snapId = 0

    var items: [[VarData]]

    init(_ length: Int) {
        items = Array(repeating: [(snapId: -1, value: 0)], count: length)
    }
    
    func set(_ index: Int, _ val: Int) {
        var data = items[index].last!
        if data.snapId == self.snapId { // replace existing
            items[index].removeLast() 
        }
        else { // add new
            data.snapId = self.snapId 
        }
        data.value = val
        items[index].append(data)
    }
    
    func snap() -> Int {
        defer { snapId += 1 }
        return snapId
    }
    
    func get(_ index: Int, _ targetSnap: Int) -> Int {
        let datas = items[index] // datas is in ascending order by snapId
        if targetSnap < 0 { return datas.first!.value } // just in case

        // binary search for last data.snapId ⩽ targetSnap
        var left = 0, right = datas.count - 1, mid = 0
        while left < right {
            mid = (left + right + 1) / 2
            if datas[mid].snapId <= targetSnap {
                left = mid
            }
            else {
                right = mid - 1
            }
        }
        
        return datas[right].value
    }
}
/**
 * Your SnapshotArray object will be instantiated and called as such:
 * let obj = SnapshotArray(length)
 * obj.set(index, val)
 * let ret_2: Int = obj.snap()
 * let ret_3: Int = obj.get(index, snap_id)
 */