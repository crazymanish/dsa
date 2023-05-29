class ParkingSystem {
    private var slots: [Int]

    init(_ big: Int, _ medium: Int, _ small: Int) {
        slots = [-1, big, medium, small]
    }
    
    func addCar(_ carType: Int) -> Bool {
        guard slots[carType] > 0 else { return false }
        
        slots[carType] -= 1
        
        return true
    }
}

/**
 * Your ParkingSystem object will be instantiated and called as such:
 * let obj = ParkingSystem(big, medium, small)
 * let ret_1: Bool = obj.addCar(carType)
 */