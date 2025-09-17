// MARK: - Complexity Analysis
// Let F be the total number of foods, and L be the number of foods in the largest cuisine.
//
// Time Complexity:
// - `init`: O(F * L). We iterate through F foods. For each food, we insert it into a `SortedArray`.
//   The `insert` operation on our custom `SortedArray` takes O(L) time in the worst case, as it may
//   need to shift all elements.
// - `changeRating`: O(L). This involves one `remove` and one `insert` on a `SortedArray` of a
//   specific cuisine, both of which are O(L) operations.
// - `highestRated`: O(1). Accessing the first element of a sorted array is a constant-time operation.
//
// Space Complexity: O(F * AvgWordLength)
// - We store information for all F foods in two dictionaries. The space is proportional to the
//   number of foods and the length of their names/cuisine strings.


/**
 * A system that manages food ratings and allows for efficiently finding the highest-rated food of a given cuisine.
 *
 * ## Core Design
 * The system uses two main data structures for efficiency:
 * 1.  `foodStats`: A dictionary `[String: (String, Int)]` that maps a food's name to its cuisine and
 * current rating. This allows for fast O(1) lookups when a food's rating needs to be changed.
 * 2.  `cuisineToRatings`: A dictionary `[String: SortedArray<FoodRating>]` that maps a cuisine to a
 * custom sorted array of `FoodRating` objects. This keeps the foods of each cuisine sorted by
 * rating and name, allowing for a very fast O(1) query to find the highest-rated food.
 *
 * ## Negated Rating Trick
 * To find the "highest" rating, we store all ratings as negative numbers. The custom `FoodRating`
 * struct sorts items in ascending order (smallest rating first, then smallest name first). By negating
 * the ratings, the highest actual rating (e.g., 10) becomes the smallest stored value (-10).
 * This allows us to find the top-rated food by simply looking for the minimum element in the sorted array.
 */
class FoodRatings {
    /// Maps a cuisine to a sorted array of its foods.
    var cuisineToRatings: [String: SortedArray<FoodRating>]
    /// Maps a food name to its cuisine and current (negated) rating for quick updates.
    var foodStats: [String: (cuisine: String, rating: Int)]
    
    init(_ foods: [String], _ cuisines: [String], _ ratings: [Int]) {
        self.cuisineToRatings = [:]
        self.foodStats = [:]
        
        // CORRECTION: Iterate by index, as Swift's `zip` only takes two sequences.
        // The problem constraints guarantee that all input arrays have the same length.
        for i in 0..<foods.count {
            let food = foods[i]
            let cuisine = cuisines[i]
            let rating = ratings[i]
            let negatedRating = -rating
            
            // Store the food's info for quick lookups during rating changes.
            foodStats[food] = (cuisine, negatedRating)
            
            // Insert the new food into the sorted array for its cuisine.
            let foodRating = FoodRating(name: food, rating: negatedRating)
            cuisineToRatings[cuisine, default: SortedArray()].insert(foodRating)
        }
    }
    
    func changeRating(_ food: String, _ newRating: Int) {
        // Look up the food's current info. The force unwrap is safe per problem constraints.
        let (cuisine, oldNegatedRating) = foodStats[food]!
        let newNegatedRating = -newRating
        
        // Update the food's stats in the lookup dictionary.
        foodStats[food] = (cuisine, newNegatedRating)
        
        // To update the sorted list, we must remove the old entry and insert the new one.
        // The force unwrap is safe as the cuisine must exist.
        cuisineToRatings[cuisine]!.remove(FoodRating(name: food, rating: oldNegatedRating))
        cuisineToRatings[cuisine]!.insert(FoodRating(name: food, rating: newNegatedRating))
    }
    
    func highestRated(_ cuisine: String) -> String {
        // Thanks to our negated rating trick and the custom sort order, the highest-rated
        // food is always the first element in the sorted array for that cuisine.
        // The force unwraps are safe per problem constraints.
        return cuisineToRatings[cuisine]!.first()!.name
    }
}

/**
 * A struct to hold a food's name and rating, conforming to `Comparable`
 * for sorting purposes.
 */
struct FoodRating: Comparable {
    let name: String
    let rating: Int // Note: This stores the NEGATED rating.

    // Sorts primarily by rating (ascending) and secondarily by name (lexicographically ascending).
    static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.rating != rhs.rating {
            return lhs.rating < rhs.rating
        }
        return lhs.name < rhs.name
    }
}

/**
 * A custom generic data structure that keeps an array sorted upon insertion.
 *
 * Note: This implementation uses a standard Swift `Array` as its backing store.
 * While the binary search to find an element's position is fast (O(log N)),
 * the actual `insert` and `remove` operations on the array can take O(N) time in the
 * worst case due to the need to shift elements.
 */
struct SortedArray<T: Comparable> {
    private var storage: [T] = []
    
    mutating func insert(_ element: T) {
        let index = findInsertionPoint(for: element)
        storage.insert(element, at: index)
    }
    
    mutating func remove(_ element: T) {
        // Find the index of the element to remove.
        if let index = findElementIndex(for: element) {
            storage.remove(at: index)
        }
    }
    
    /// Finds the index for a specific element. O(log N). Returns nil if not found.
    private func findElementIndex(for target: T) -> Int? {
        var (low, high) = (0, storage.count - 1)
        while low <= high {
            let mid = low + (high - low) / 2
            if storage[mid] == target {
                // To handle duplicates, we might need to scan left/right,
                // but this problem's logic avoids removing ambiguous elements.
                return mid
            } else if storage[mid] < target {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        return nil
    }
    
    /// Finds the correct insertion point to maintain sort order. O(log N).
    private func findInsertionPoint(for target: T) -> Int {
        var (low, high) = (0, storage.count)
        while low < high {
            let mid = low + (high - low) / 2
            if storage[mid] < target {
                low = mid + 1
            } else {
                high = mid
            }
        }
        return low
    }
    
    /// Returns the first (and therefore minimum) element in O(1).
    func first() -> T? {
        return storage.first
    }
}

/**
 * Your FoodRatings object will be instantiated and called as such:
 * let obj = FoodRatings(foods, cuisines, ratings)
 * obj.changeRating(food, newRating)
 * let ret_2: String = obj.highestRated(cuisine)
 */