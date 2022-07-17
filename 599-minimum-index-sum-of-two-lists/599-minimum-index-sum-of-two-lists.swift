class Solution {
    func findRestaurant(_ list1: [String], _ list2: [String]) -> [String] {
        let hashMapList1 = hashMap(list1)
        let hashMapList2 = hashMap(list2)

        let hashMapRestaurants = findRestaurant(hashMapList1, hashMapList2)
        
        var minimumKey = Int.max
        for (key, _) in hashMapRestaurants {
             minimumKey = min(minimumKey, key)
        }
        
        return hashMapRestaurants[minimumKey] ?? []
    }

    private func findRestaurant(
        _ hashMapList1: [String : Int],
        _ hashMapList2: [String : Int]) -> [Int : [String]] {
        var hashMap: [Int : [String]] = [:]

        for (key, value) in hashMapList1 {
            if let value2 = hashMapList2[key] {
                let sum = value + value2
                hashMap[sum] = (hashMap[sum] ?? []) + [key]
            }
        }

        return hashMap
    }

    private func hashMap(_ list: [String]) -> [String : Int] {
        var hashMap: [String : Int] = [:]

        var index = 0
        for text in list {
            hashMap[text] = index
            
            index += 1
        }

        return hashMap
    }
}