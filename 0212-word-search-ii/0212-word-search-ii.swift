class TrieNode {
    var value: Character?
    var children: [Character: TrieNode]
    var word: String?
    init() {
        self.value = nil
        self.children = [Character: TrieNode]()
        self.word = nil
    }
    init(value: Character) {
        self.value = value
        self.children = [Character: TrieNode]()
        self.word = nil
    }
    func add(value: Character) {
        if children[value] == nil {
            children[value] = TrieNode(value: value)
        }
    }
}
class Trie {
    typealias Node = TrieNode
    var root: Node
    init() {
        root = Node()
    }
    func insert(word: String) {
        var currentNode = root
        for c in word {
            if let childNode = currentNode.children[c] {
                currentNode = childNode
            } else {
                currentNode.add(value: c)
                currentNode = currentNode.children[c]!
            }
        }
        currentNode.word = word
    }
    func searchOnBoard(_ board: [[Character]]) -> [String] {
        let row = board.count, col = board[0].count
        var result = [String]()
        for r in 0...row-1 {
            for c in 0...col-1 {
                if root.children[board[r][c]] != nil {
                    var newBoard = board
                    backtracking(r, c, root, &newBoard, &result)
                }
            }
        }
        return result
    }
    func backtracking(_ r: Int, _ c: Int, _ node: TrieNode, _ newBoard: inout [[Character]], _ result: inout [String]) {
        //print("backtracking, r:\(r), c:\(c), \(newBoard)")
        let currentLetter = newBoard[r][c]
        var currentNode = node.children[currentLetter]!
        if let endWord = currentNode.word {
            result.append(endWord)
            currentNode.word = nil
        }
        newBoard[r][c] = Character("#")
        let rowOffset = [-1, 0, 1, 0]
        let colOffset = [0, 1, 0, -1]
        for i in 0...3 {
            let newRow = r + rowOffset[i]
            let newCol = c + colOffset[i]
            if newRow < 0 || newRow >= newBoard.count || newCol < 0 || newCol >= newBoard[0].count {
                continue
            }
            if currentNode.children[newBoard[newRow][newCol]] != nil {
                backtracking(newRow, newCol, currentNode, &newBoard, &result)
            }
        }
        newBoard[r][c] = currentLetter
        // optimization, because we only need to check if it exists, rather than how many times it appears.
        if currentNode.children.isEmpty {
            node.children.removeValue(forKey: currentLetter)
        }
    }
}
class Solution {
    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        var trieTree = Trie()
        for w in words {
            trieTree.insert(word: w)
        }
        return trieTree.searchOnBoard(board)
    }
}

/*
class Solution {
    class TrieNode {
	var word: String?
	var children = [Character: TrieNode]()
}

func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
	if board.isEmpty { return [] }

	var result = [String]()
	var board = board
	let root = buildTrie(with: words)

	for i in 0..<board.count {
		for j in 0..<board[0].count {
			check(&board, i, j, root, &result)
		}
	}

	return result
}

func buildTrie(with words: [String]) -> TrieNode {
	let root = TrieNode()

	for word in words {
		var node = root
		for char in word {
			if node.children[char] == nil{
				node.children[char] = TrieNode()
			}
			node = node.children[char]!
		}
		node.word = word
	}

	return root
}

func check(_ board: inout [[Character]], _ i: Int, _ j: Int, _ node: TrieNode, _ result: inout [String]) {
	if i < 0 || j < 0 || i >= board.count || j >= board[0].count { return }
	guard let currNode = node.children[board[i][j]] else { return }

	if let word = currNode.word { 
		result.append(word) 
		currNode.word = nil
	}
	let char = board[i][j]
	board[i][j] = "0"

	check(&board, i - 1, j, currNode, &result)
	check(&board, i + 1, j, currNode, &result)
	check(&board, i, j - 1, currNode, &result)
	check(&board, i, j + 1, currNode, &result)
	board[i][j] = char
}
}

class Solution {
    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        let (countI, countJ) = (board.count, board.first!.count)
        var characterSet: Set<Character> = []
        
        board.forEach { characters in
            characters.forEach { characterSet.insert($0) }
        }

        func check(word: String, i: Int, j: Int, listSet: Set<String>) -> Bool {
            if word.isEmpty { return true }
            let list = [(i-1,j), (i+1,j), (i,j-1), (i,j+1)]
            var word = word
            let char = word.removeFirst()
            return list.first { i, j in
                guard 0 <= i, i < countI, 0 <= j, j < countJ else { return false }
                guard char == board[i][j], !listSet.contains("\(i),\(j)") else { return false }
                var listSet = listSet
                listSet.insert("\(i),\(j)")
                return check(word: word, i: i, j: j, listSet: listSet)
            } != nil
        }

        return words
            .filter { $0.allSatisfy { characterSet.contains($0) } }
            .filter {
                var word = $0
                let char = word.removeFirst()
                return (0..<countI).first { i in
                    (0..<countJ).first { j in
                        char == board[i][j] ? check(word: word, i: i, j: j, listSet: ["\(i),\(j)"]) : false
                    } != nil
                } != nil
            }
    }
}
*/