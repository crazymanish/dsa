// MARK: - Complexity Analysis
// Let E be the number of initial `entries`.
// Let R be the number of currently rented movies.
// Let L_m be the maximum number of copies of any single movie across all shops.
//
// Time Complexity:
// - `init`: O(E * log E). Dominated by the initial sorting of the `entries` array. Building
//   the dictionaries afterwards is O(E).
// - `search`: O(L_m). We iterate through the pre-sorted list of shops for a given movie.
//   The loop breaks after finding 5 available shops, but in the worst case, it checks all copies.
// - `rent`: O(1) amortized. Dictionary lookups and updates are O(1), and appending to an
//   array is O(1) on average.
// - `drop`: O(R). The dictionary update is O(1), but finding the movie in the `rented`
//   array requires a linear scan, which takes O(R) time.
// - `report`: O(R * log R). This is the most expensive operation. It requires sorting the
//   entire list of `R` rented movies each time it's called.
//
// Space Complexity: O(E)
// - The `movies` and `shops` dictionaries store information for every unique `(shop, movie)`
//   pair, which is proportional to E. The `rented` array can also grow up to size E.

/**
 * A system for renting movies from various shops, with features to search for available
 * movies and report on currently rented ones.
 *
 * ## Core Design
 * The system is built around three main data structures to optimize for different operations:
 * 1.  **`shops` (Dictionary):** `[ShopID: [MovieID: (Price, IsRented)]]`
 * This is the primary source of truth for the state of any specific movie in any shop.
 * It provides fast O(1) lookups for `rent`, `drop`, and `search` status checks.
 *
 * 2.  **`movies` (Dictionary):** `[MovieID: [(ShopID, Price)]]`
 * This structure is optimized for the `search` function. Each movie maps to a list of shops
 * that carry it. Crucially, this list is **pre-sorted by price, then shop ID** during
 * initialization. This avoids costly sorting during search queries.
 *
 * 3.  **`rented` (Array):** `[(ShopID, MovieID)]`
 * A simple list of all currently rented movies. This is used to generate the `report`.
 * Sorting this list at query time is the main performance bottleneck of the `report` function.
 */
class MovieRentingSystem {
    private let maxNumSearchResults = 5
    
    // movie -> [(shop, price)], pre-sorted by price then shop
    private var movies: [Int: [(shop: Int, price: Int)]]
    
    // shop -> movie -> (price, rented flag)
    private var shops: [Int: [Int: (price: Int, rented: Bool)]]
    
    // A list of currently rented (shop, movie) pairs
    private var rented: [(shop: Int, movie: Int)]
    
    init(_ n: Int, _ entries: [[Int]]) {
        self.movies = [:]
        self.shops = [:]
        self.rented = []
        
        // Pre-sort all entries by price, then by shop ID. This is a key optimization
        // that allows us to build the `movies` dictionary with already-sorted lists.
        let sortedEntries = entries.sorted { entryA, entryB in
            let priceA = entryA[2], priceB = entryB[2]
            let shopA = entryA[0], shopB = entryB[0]
            
            if priceA != priceB {
                return priceA < priceB
            }
            return shopA < shopB
        }
        
        // Build the `movies` and `shops` dictionaries from the sorted entries.
        for entry in sortedEntries {
            let shop = entry[0], movie = entry[1], price = entry[2]
            
            movies[movie, default: []].append((shop, price))
            
            if shops[shop] == nil {
                shops[shop] = [:]
            }
            shops[shop]![movie] = (price, false) // All movies are initially available.
        }
    }
    
    /// Finds the 5 cheapest available shops for a given movie.
    func search(_ movie: Int) -> [Int] {
        guard let shopPriceList = movies[movie] else { return [] }
        
        var results: [Int] = []
        // Iterate through the pre-sorted list of shops.
        for (shop, _) in shopPriceList {
            if results.count >= maxNumSearchResults { break }
            
            // Check the current rental status in the `shops` dictionary.
            if let movieData = shops[shop]?[movie], !movieData.rented {
                results.append(shop)
            }
        }
        return results
    }
    
    /// Rents a movie from a shop, updating its status.
    func rent(_ shop: Int, _ movie: Int) {
        // Look up the movie in our main state dictionary.
        if var movieData = shops[shop]?[movie], !movieData.rented {
            // Update the rented status.
            movieData.rented = true
            shops[shop]?[movie] = movieData
            
            // Add to the list of currently rented movies.
            rented.append((shop, movie))
        }
    }
    
    /// Drops off a movie at a shop, making it available again.
    func drop(_ shop: Int, _ movie: Int) {
        if var movieData = shops[shop]?[movie], movieData.rented {
            // Update the rented status.
            movieData.rented = false
            shops[shop]?[movie] = movieData
            
            // Remove from the rented list. This is an O(R) operation and a potential bottleneck.
            if let index = rented.firstIndex(where: { $0.shop == shop && $0.movie == movie }) {
                rented.remove(at: index)
            }
        }
    }
    
    /// Reports the 5 cheapest currently rented movies.
    func report() -> [[Int]] {
        // Sort the list of rented movies at query time. This is an O(R * log R) operation
        // and the main bottleneck of this function. For a system with frequent reports,
        // using a sorted data structure (like a Balanced BST or a custom SortedSet) for `rented`
        // would be a key optimization.
        let sortedRented = rented.sorted { a, b in
            // Look up prices in the `shops` dictionary for sorting.
            let priceA = shops[a.shop]![a.movie]!.price
            let priceB = shops[b.shop]![b.movie]!.price
            
            if priceA != priceB { return priceA < priceB }   // Primary sort: price
            if a.shop != b.shop { return a.shop < b.shop }   // Secondary sort: shop ID
            return a.movie < b.movie                         // Tertiary sort: movie ID
        }
        
        // Take the top 5 cheapest, format, and return.
        return Array(sortedRented.prefix(maxNumSearchResults)).map { [$0.shop, $0.movie] }
    }
}

/**
 * Your MovieRentingSystem object will be instantiated and called as such:
 * let obj = MovieRentingSystem(n, entries)
 * let ret_1: [Int] = obj.search(movie)
 * obj.rent(shop, movie)
 * obj.drop(shop, movie)
 * let ret_4: [[Int]] = obj.report()
 */