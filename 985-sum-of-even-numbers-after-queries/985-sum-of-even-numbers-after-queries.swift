class Solution {
    func sumEvenAfterQueries(_ A: [Int], _ queries: [[Int]]) -> [Int] {
        
        var arrayA = A
        var sumEvenResult = [Int]()
        var evenSum = arrayA.filter({$0 % 2 == 0}).reduce(0, +)

        for query in queries {

            let add = query[0]
            let index = query[1]
            let numberToQuery = arrayA[index]
            let result = numberToQuery + add

            if numberToQuery % 2 == 0 { //number was even
                if result % 2 == 0 {
                    //only add the add to even total as number already counted
                    evenSum += add
                } else {
                    //was even and now odd so remove number from the even total
                    evenSum -= numberToQuery
                }
            } else { //number was odd
                if result % 2 == 0 {
                    //was odd and now even, so add whole num plus add (result) to even total
                    evenSum += result
                } else {
                    //number still odd so do nothing
                }
            }
            sumEvenResult.append(evenSum)
            arrayA[index] += add //modify the number in the array
        }
        
        return sumEvenResult
    }
}