class Solution {
    // Static constants for alphabet size and modulo value
    private static let ALPHABET_SIZE = 26
    private static let MOD = 1_000_000_007 // Standard LeetCode modulo

    // Type alias for matrices for clarity
    private typealias Matrix = [[Int]]

    // Helper function to create an identity matrix of ALPHABET_SIZE x ALPHABET_SIZE
    // Time Complexity: O(N_alpha^2)
    private func identityMatrix() -> Matrix {
        var matrix = Array(repeating: Array(repeating: 0, count: Self.ALPHABET_SIZE), count: Self.ALPHABET_SIZE)
        for i in 0..<Self.ALPHABET_SIZE {
            matrix[i][i] = 1
        }
        return matrix
    }

    // Helper function: matMul - Multiplies two matrices, matrixA and matrixB.
    // Uses Self.MOD for modulo operations.
    // Relies on Int being 64-bit to prevent overflow for intermediate products.
    // Time Complexity: O(RowsA * ColsB * ColsA).
    private func matMul(_ matrixA: Matrix, _ matrixB: Matrix) -> Matrix {
        let numRowsA = matrixA.count
        guard numRowsA > 0 else {
            // This might happen if an upstream function returns an empty matrix due to an error.
            // Depending on expected guarantees, could return [] or fatalError.
            // Given the problem structure, an empty matrix input to matMul signals an issue.
            fatalError("matrixA cannot be empty in matMul.")
        }
        let numColsA = matrixA[0].count // Assuming matrixA is not ragged.
        
        let numRowsB = matrixB.count
        guard numRowsB > 0 else {
            fatalError("matrixB cannot be empty in matMul.")
        }
        let numColsB = matrixB[0].count

        // Standard matrix multiplication requires numColsA == numRowsB
        guard numColsA == numRowsB else {
            fatalError("Incompatible matrix dimensions: \(numRowsA)x\(numColsA) vs \(numRowsB)x\(numColsB)")
        }

        var resultMatrix = Array(repeating: Array(repeating: 0, count: numColsB), count: numRowsA)
        
        for i in 0..<numRowsA {
            for j in 0..<numColsB {
                var cellSum: Int = 0 // Using Int, assuming it's 64-bit and can hold sums before modulo.
                for k in 0..<numColsA { // numColsA is the common dimension (cols of A / rows of B)
                    // Assuming Int is 64-bit:
                    // matrixA[i][k] and matrixB[k][j] are < MOD (~10^9).
                    // productTerm can be up to (MOD-1)^2 ~10^18, which fits 64-bit Int.
                    let productTerm: Int = matrixA[i][k] * matrixB[k][j]
                    
                    // cellSum (0 to MOD-1) + productTerm (~10^18) must fit in Int before modulo.
                    // (sum) % MOD keeps cellSum in 0..MOD-1 range if sum is non-negative.
                    cellSum = (cellSum + productTerm) % Self.MOD
                }
                // Ensure cellSum is in [0, MOD-1] range.
                // If cellSum could become negative (e.g. if matrix elements could be negative),
                // (cellSum % Self.MOD + Self.MOD) % Self.MOD is required.
                // Here, all inputs are non-negative, so cellSum will be non-negative.
                // The % Self.MOD above already ensures it's < Self.MOD.
                if cellSum < 0 { cellSum += Self.MOD } // Defensively ensure positive.
                resultMatrix[i][j] = cellSum
            }
        }
        return resultMatrix
    }

    // Helper function: matPow - Calculates baseMatrix^exponent.
    // Assumes baseMatrix is a square matrix.
    // Time Complexity: O(N_alpha^3 * log exponent).
    private func matPow(_ baseMatrix: Matrix, _ exponent: Int) -> Matrix {
        guard !baseMatrix.isEmpty else { 
            fatalError("Base matrix for power function cannot be empty.")
        }
        // Problem context implies square matrices of ALPHABET_SIZE.
        // A check can be added for robustness if matrix dimensions could vary:
        guard baseMatrix.count == Self.ALPHABET_SIZE && baseMatrix[0].count == Self.ALPHABET_SIZE else {
             fatalError("Base matrix must be \(Self.ALPHABET_SIZE)x\(Self.ALPHABET_SIZE).")
        }

        var resultMatrix = identityMatrix() // Creates ALPHABET_SIZE x ALPHABET_SIZE identity
        var remainingExponent = exponent
        var currentPowerOfBase = baseMatrix // This is baseMatrix^1 initially
        
        while remainingExponent > 0 {
            if remainingExponent & 1 == 1 { // If current bit of exponent is 1
                resultMatrix = matMul(resultMatrix, currentPowerOfBase)
            }
            // Square the current power of base for the next iteration (e.g., M -> M^2 -> M^4)
            currentPowerOfBase = matMul(currentPowerOfBase, currentPowerOfBase)
            remainingExponent >>= 1 // Move to the next bit of the exponent
        }
        return resultMatrix
    }

    // s: initial string
    // numTransformations: number of transformation steps
    // productionRulesPerChar: An array where productionRulesPerChar[i] defines how character ('a'+i) transforms.
    func lengthAfterTransformations(_ initialString: String, _ numTransformations: Int, _ productionRulesPerChar: [Int]) -> Int {
        // Initialize singleStepTransformationMatrix to ALPHABET_SIZE x ALPHABET_SIZE
        var singleStepTransformationMatrix = Array(repeating: Array(repeating: 0, count: Self.ALPHABET_SIZE), count: Self.ALPHABET_SIZE)
        
        for sourceCharIndex in 0..<Self.ALPHABET_SIZE {
            // Ensure productionRulesPerChar is long enough for current sourceCharIndex
            guard sourceCharIndex < productionRulesPerChar.count else { continue }
            let numProducts = productionRulesPerChar[sourceCharIndex]
            
            // If numProducts is 0, the inner loop 1...0 will not run.
            for offset in 1...numProducts {
                // No need for "if numProducts == 0 { break }" as 1...0 loop is empty.
                let targetCharIndex = (sourceCharIndex + offset) % Self.ALPHABET_SIZE
                singleStepTransformationMatrix[sourceCharIndex][targetCharIndex] = 1
            }
        }
        
        // If numTransformations is 0, matPow returns identity matrix.
        // M^0 * counts = counts. This is correct.
        let overallTransformationMatrix = matPow(singleStepTransformationMatrix, numTransformations)
        
        // Calculate initial character counts from 'initialString'
        var initialCharCounts = Array(repeating: 0, count: Self.ALPHABET_SIZE)
        for charUTF8Value in initialString.utf8 {
            let charIndex = Int(charUTF8Value - Character("a").utf8.first!) // 'a' -> 0, 'b' -> 1, ...
            if charIndex >= 0 && charIndex < Self.ALPHABET_SIZE { // Ensure it's a lowercase English letter
                initialCharCounts[charIndex] = (initialCharCounts[charIndex] + 1) % Self.MOD
            }
        }
        
        // For matMul: matrixA is 1xN, matrixB is NxN. Result is 1xN.
        // Pass initialCharCounts as a 2D array (matrix with one row).
        let finalCharCountsMatrix = matMul([initialCharCounts], overallTransformationMatrix)
        
        // Sum all character counts in the final result vector
        var totalLength: Int = 0 // Using Int, assuming it's 64-bit
        if !finalCharCountsMatrix.isEmpty && !finalCharCountsMatrix[0].isEmpty {
            for countOfCharType in finalCharCountsMatrix[0] {
                // countOfCharType is < MOD. totalLength is < MOD. Sum is < 2*MOD. Fits Int.
                totalLength = (totalLength + countOfCharType) % Self.MOD
            }
        }
        
        // Ensure final result is non-negative (though with current logic, it should be)
        if totalLength < 0 { totalLength += Self.MOD }
        return totalLength
    }
}