// MARK: - Complexity Analysis
// Let R be the max number of rows, C be the max number of columns.
// Let F be the length of a formula string, and T be the number of terms in it.
//
// Time Complexity:
// - `init`: O(R * C). To initialize the storage array.
// - `setCell`, `resetCell`: O(L), where L is the length of the cell name. This is for parsing
//   the name, which is effectively constant time.
// - `getValue`: O(F). The function needs to parse the entire formula string, splitting it
//   into T terms and evaluating each one.
//
// Space Complexity: O(R * C)
// - The `cellValues` array is the dominant data structure, storing a value for each
//   potential cell in the spreadsheet.


/**
 * A simplified spreadsheet that supports setting cell values and evaluating basic sum formulas.
 *
 * ## Core Design
 * The spreadsheet is represented by a single, flat 1D array (`cellValues`). Cell coordinates
 * like "A1", "B2", etc., are converted into an index into this array. This approach avoids
 * complex 2D data structures.
 *
 * The `getValue` function acts as a simple formula engine that can parse strings containing
 * cell names and literal numbers separated by '+', and returns their sum.
 */
class Spreadsheet {
    // --- Constants and Properties ---

    // Define the dimensions of our spreadsheet grid.
    private static let maxColumns = 26 // A-Z
    private static let maxRows = 1000
    
    /// A 1D array to store the values of all cells.
    private var cellValues = [Int](repeating: 0, count: maxColumns * (maxRows + 1))
    
    /// The initializer is a no-op as the spreadsheet has fixed dimensions.
    init(_: Int) {}
    
    // --- Public Methods ---

    /// Sets the value of a specific cell.
    func setCell(_ cellName: String, _ value: Int) {
        // Convert the cell name to an array index and update the value.
        guard let index = cellNameToIndex(cellName) else {
            print("Error: Invalid cell name '\(cellName)'")
            return
        }
        cellValues[index] = value
    }
    
    /// Resets a cell's value back to 0.
    func resetCell(_ cellName: String) {
        setCell(cellName, 0)
    }
    
    /// Evaluates a formula string (e.g., "=A1+5+B2") and returns the sum.
    func getValue(_ formula: String) -> Int {
        // A formula must start with '='.
        guard formula.starts(with: "=") else {
            return 0 // Or handle as an error
        }
        
        // Split the formula into terms by the '+' separator.
        let terms = formula.dropFirst().split(separator: "+")
        
        // Evaluate each term and sum the results.
        return terms.map { evaluateTerm($0) }.reduce(0, +)
    }
    
    // --- Private Helper Functions ---
    
    /**
     * Converts a spreadsheet cell name (e.g., "A1", "Z25") into an index for the `cellValues` array.
     * The mapping is `index = (rowNumber * columnCount) + column_index`.
     *
     * - Parameter cellName: A string or substring representing the cell.
     * - Returns: An optional integer index, or `nil` if the name is invalid.
     */
    private func cellNameToIndex<S: StringProtocol>(_ cellName: S) -> Int? {
        // A valid cell name must have at least two characters (e.g., "A1").
        guard let columnChar = cellName.first, cellName.count >= 2 else { return nil }
        
        // The column character must be an uppercase letter.
        guard columnChar.isASCII && columnChar.isUppercase else { return nil }
        let columnIndex = Int(columnChar.asciiValue! - Character("A").asciiValue!)
        
        // The rest of the string must be a valid row number.
        let rowString = cellName.dropFirst()
        guard let rowIndex = Int(rowString), rowIndex > 0, rowIndex <= Self.maxRows else { return nil }

        // Calculate the final index in the 1D array.
        return (rowIndex * Self.maxColumns) + columnIndex
    }
    
    /**
     * Evaluates a single term from a formula string.
     * A term can be either a literal number (e.g., "5") or a cell name (e.g., "A1").
     *
     * - Parameter term: The substring representing the term.
     * - Returns: The integer value of the term.
     */
    private func evaluateTerm<S: StringProtocol>(_ term: S) -> Int {
        // First, try to parse the term as a literal integer.
        if let literalValue = Int(term) {
            return literalValue
        }
        
        // If that fails, assume it's a cell name and look up its value.
        if let index = cellNameToIndex(term) {
            return cellValues[index]
        }
        
        // If the term is neither a valid number nor a valid cell name, treat its value as 0.
        return 0
    }
}

/**
 * Your Spreadsheet object will be instantiated and called as such:
 * let obj = Spreadsheet(rows)
 * obj.setCell(cell, value)
 * obj.resetCell(cell)
 * let ret_3: Int = obj.getValue(formula)
 */