class Solution {
    func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
		var res = false
		var count = 1
        var wordSet = Set(wordList)
		var queue: [String] = [beginWord]
		
        loop: 
        while queue.count > 0 {
			count += 1
			var list: [String] = []
			
            for word in queue {
				list += nextWords(word, &wordSet)
				if list.contains(endWord) {
					res = true
					break loop
				}
			}
			
            queue = list
		}
        
		return res == true ? count : 0
    }
    
    
    func nextWords(_ word: String, _ wordSet: inout Set<String>) -> [String] {
		var res: [String] = []
		var chars = Array(word)
		let alphabeta = Array("abcdefghijklmnopqrstvuwxyz")
		
        for (i, char) in chars.enumerated() {
			for c in alphabeta {
				if c == char { continue } 
				else {
					chars[i] = c
					let string = String(chars)
					if wordSet.contains(string) {
						res.append(string)
						wordSet.remove(string)
					}
				}
                
				chars[i] = char
			}
		}
        
		return res
	}

}
