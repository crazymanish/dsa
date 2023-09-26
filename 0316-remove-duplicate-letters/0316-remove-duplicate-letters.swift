class Solution {
    func removeDuplicateLetters(_ s: String) -> String {
        var hashMap = [Character: Int]()

        for (index, character) in s.enumerated() {
            hashMap[character] = index // Note: we are overriding the index, meaning hashMap will only carry the last index of a char!
        }

        var stack = [Character]()
        var visited = Set<Character>()

        for (index, character) in s.enumerated() {
            // This Character you have already visited,
            // and whatever we have constructed below is already Lexicograhical, so there is No use of this Character.
            if visited.contains(character) {
                continue
            }

            // delete ONLY those characters, which you know are going to appear later ( coz of hashMap you created) and are bigger than
            // the current one, so right now they have no use
            while !stack.isEmpty && stack.last! > character && hashMap[stack.last!, default: Int.min] > index {
                visited.remove(stack.last!)
                stack.removeLast()
            }

            visited.insert(character)
            stack.append(character)
        }

        return String(stack)
    }
}