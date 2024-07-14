class Solution {
    func countOfAtoms(_ formula: String) -> String {
        var index = formula.startIndex
        
        
        func parse(_ formula: String) -> [String: Int] {
            var counts: [String: Int] = [:]
        
            while index < formula.endIndex {
                let char = formula[index]
            
                if char == "(" {
                    // Move index past '('
                    index = formula.index(after: index)
                    let innerCounts = parse(formula)
                
                    // Find the multiplicity after ')'
                    let start = index
                    while index < formula.endIndex && formula[index].isNumber {
                        index = formula.index(after: index)
                    }
                    let multiplicity = start < index ? Int(formula[start..<index])! : 1
                
                    // Merge inner counts with the outer counts, considering the multiplicity
                    for (atom, count) in innerCounts {
                        counts[atom, default: 0] += count * multiplicity
                    }
                } else if char == ")" {
                    // Move index past ')'
                    index = formula.index(after: index)
                    return counts
                } else {
                    // Parse the element name
                    let start = index
                    index = formula.index(after: index)
                
                    while index < formula.endIndex && formula[index].isLowercase {
                        index = formula.index(after: index)
                    }
                    let element = String(formula[start..<index])
                
                    // Find the multiplicity after the element name
                    let startNum = index
                    while index < formula.endIndex && formula[index].isNumber {
                        index = formula.index(after: index)
                    }
                    let multiplicity = startNum < index ? Int(formula[startNum..<index])! : 1
                
                    // Add the element to the counts
                    counts[element, default: 0] += multiplicity
                }
            }
        
            return counts
        }
        
        let counts = parse(formula)
        
        // Sort the elements by name and construct the result string
        let sortedElements = counts.keys.sorted()
        var result = ""
        for element in sortedElements {
            result += element
            if counts[element]! > 1 {
                result += String(counts[element]!)
            }
        }
        return result
    }
}