class FoodRatings {
    var foodRating: [String: SortedArray<FoodRating>]
    var foodStat: [String: (String, Int)]
    init(_ foods: [String], _ cuisines: [String], _ ratings: [Int]) {
        foodRating = [:]
        foodStat = [:]
        for (cuisine, (food, rating)) in zip(cuisines, zip(foods, ratings)) {
            foodRating[cuisine, default: SortedArray()].insert(FoodRating(name: food, rating: -rating))
            foodStat[food] = (cuisine, -rating)
        }
    }
    
    func changeRating(_ food: String, _ newRating: Int) {
        let (cuisine, rating) = foodStat[food]!
        foodStat[food] = (cuisine, -newRating)
        foodRating[cuisine]!.remove(FoodRating(name: food, rating: rating))
        foodRating[cuisine]!.insert(FoodRating(name: food, rating: -newRating))
    }
    
    func highestRated(_ cuisine: String) -> String {
        foodRating[cuisine]!.min()!.name
    }
}

struct FoodRating: Comparable {
    let name: String
    let rating: Int

    static func < (lhs: Self, rhs: Self) -> Bool {
        (lhs.rating, lhs.name) < (rhs.rating, rhs.name)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        (lhs.rating, lhs.name) == (rhs.rating, rhs.name)
    }
}

struct SortedArray<T: Comparable> {
    private var array: [T] = []
    var count: Int { array.count }
    
    init(_ array: [T]? = []) {
        for element in array ?? [] {
            self.insert(element)
        }
    }
    
    mutating func insert(_ element: T) {
        let index = bisectRight(element)
        array.insert(element, at: index)
    }
    
    mutating func remove(_ value: T) {
        let index = bisectRight(value) - 1
        array.remove(at: index)
    }
    
    private func bisectRight(_ target: T) -> Int {
        var (low, high) = (0, count)
        
        while low < high {
            let mid = low + (high-low) / 2
            if array[mid] <= target {
                low = mid + 1
            } else {
                high = mid
            }
        }
        return low
    }
    
    func min() -> T? {
        array.min()
    }
}

/**
 * Your FoodRatings object will be instantiated and called as such:
 * let obj = FoodRatings(foods, cuisines, ratings)
 * obj.changeRating(food, newRating)
 * let ret_2: String = obj.highestRated(cuisine)
 */