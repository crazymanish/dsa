class Solution {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let hashMap1 = hashMap(nums1)
        let hashMap2 = hashMap(nums2)

        if nums1.count < nums2.count {
            return intersect(hashMap1, hashMap2)
        } else {
            return intersect(hashMap2, hashMap1)
        }
    }

    private func intersect(
        _ hashMap1: [Int : Int],
        _ hashMap2: [Int : Int]) -> [Int] {
        var outputArray: [Int] = []

        for (key, value) in hashMap1 {
            let value2 = hashMap2[key] ?? 0
            let minValue = min(value, value2)
            
            for _ in 0..<minValue {
               outputArray.append(key) 
            }
        }

        return outputArray
    }

    private func hashMap(_ nums: [Int]) -> [Int : Int] {
        var hashMap: [Int : Int] = [:]

        for num in nums {
            let hashMapValue = hashMap[num] ?? 0
            hashMap[num] = hashMapValue + 1
        }

        return hashMap
    }
}