class Solution {
    func maximumBeauty(_ items: [[Int]], _ queries: [Int]) -> [Int] {
        // Sort "items" by price and, in case of tie, by beauty.
        let items = items.sorted { ($0[0], $0[1]) < ($1[0], $1[1]) }

        // Compute the maximum beauty for each price in "items".
        // Note that if there is a tie in the price, the last item
        // at that price, will have the greatest beauty for that price.
        var maximumBeautyForPrice = items
        for i in stride(from: 1, to: items.count, by: 1) {
            maximumBeautyForPrice[i][1] = max(
                maximumBeautyForPrice[i - 1][1], 
                items[i][1]
            ) 
        }

        return queries.map(maximumBeauty)

        // Binary search on the price to find the maximum beauty.
        // This is a modified version of binary search that handles
        // repeated elements (prices) and searches for the element at
        // the rightmost among these repeated elements.
        func maximumBeauty(maxPrice: Int) -> Int {
            var (lo, hi) = (0, maximumBeautyForPrice.count - 1)
            var res = 0

            while lo <= hi {
                let mid = lo + (hi - lo) / 2
                if maximumBeautyForPrice[mid][0] <= maxPrice {
                    res = maximumBeautyForPrice[mid][1]
                    lo = mid + 1
                } else {
                    hi = mid - 1
                }
            }

            return res 
        }
    }
}