// https://leetcode.com/problems/apply-discount-every-n-orders


class Cashier {
    let n: Int
    let discount: Int
    var hashMapProductPrice: [Int : Int] = [:]
    var currentCustomerNumber = 0
    
    init(_ n: Int, _ discount: Int, _ products: [Int], _ prices: [Int]) {
        self.n = n
        self.discount = discount
        
        for index in 0..<products.count {
            hashMapProductPrice[products[index]] = prices[index]
        }
    }
    
    func getBill(_ product: [Int], _ amount: [Int]) -> Double {
        currentCustomerNumber += 1  
        
        var actualBill = 0.0
        
        for index in 0..<product.count {
           actualBill += Double(hashMapProductPrice[product[index]]! * amount[index])
        }
        
        // apply discount
        if currentCustomerNumber % n == 0 {
            actualBill = actualBill * (Double(100 - discount) / Double(100))
        }
        
        return actualBill
    }
}

/**
 * Your Cashier object will be instantiated and called as such:
 * let obj = Cashier(n, discount, products, prices)
 * let ret_1: Double = obj.getBill(product, amount)
 */