class Solution {
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        let hashMapRansomNote = hashMap(ransomNote)
        let hashMapMagazine = hashMap(magazine)

        return canConstruct(hashMapRansomNote, hashMapMagazine)
    }

    private func canConstruct(
        _ hashMapRansomNote: [Character : Int],
        _ hashMapMagazine: [Character : Int]) -> Bool {
        var canConstruct = true

        for (key, value) in hashMapRansomNote {
            let sValue = hashMapMagazine[key] ?? -1
            if value > sValue  {
                canConstruct = false
                break
            }
        }

        return canConstruct
    }

    private func hashMap(_ text: String) -> [Character : Int] {
        var hashMap: [Character : Int] = [:]

        for char in text {
            let hashMapValue = hashMap[char] ?? 0
            hashMap[char] = hashMapValue + 1
        }

        return hashMap
    }
}