class Solution {
    func displayTable(_ orders: [[String]]) -> [[String]] {
        var tables: Set<Int> = []
        var foodItems: Set<String> = []
        var hashMap: [Int : [String : Int]] = [:]
        
        for order in orders {
            let tableNumber = Int(order[1])!
            let foodItem = order[2]
            
            tables.insert(tableNumber)
            foodItems.insert(foodItem)
            
            var hashMapValue = hashMap[tableNumber] ?? [:]
            let footItemCount = hashMapValue[foodItem] ?? 0
            hashMapValue[foodItem] = footItemCount + 1
            hashMap[tableNumber] = hashMapValue
        }
        
        var output: [[String]] = []
        
        var outputRow: [String] = ["Table"]
        for foodItem in foodItems.sorted() {
            outputRow.append(foodItem)
        }
        
        output.append(outputRow)
        
        for table in tables.sorted() {
            let foodHashMap = hashMap[table]!
            var outputRow: [String] = ["\(table)"]
            for foodItem in foodItems.sorted() {
                let foodValue = foodHashMap[foodItem] ?? 0
                outputRow.append("\(foodValue)")
            }
            output.append(outputRow)
        }
        
        return output
    }
}