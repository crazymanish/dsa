// https://leetcode.com/problems/simple-bank-system


class Bank {
    typealias AccountNumber = Int
    typealias Balance = Double
    var accountHashMap: [AccountNumber : Balance] = [:]
    
    init(_ balance: [Int]) {
        for accountNumber in 1...balance.count {
            accountHashMap[accountNumber] = Double(balance[accountNumber-1])
        }
    }
    
    func transfer(_ account1: Int, _ account2: Int, _ money: Int) -> Bool {
        let account1HashMapValue = accountHashMap[account1]
        let account2HashMapValue = accountHashMap[account2]
        let moneyInDouble = Double(money)

        if account1HashMapValue == nil || account2HashMapValue == nil { return false }
        if account1HashMapValue! <= moneyInDouble { return false } // Not enough money
        
        accountHashMap[account1] = account1HashMapValue! - moneyInDouble
        accountHashMap[account2] = account2HashMapValue! + moneyInDouble
        
        return true
    }
    
    func deposit(_ account: Int, _ money: Int) -> Bool {
        let accountHashMapValue = accountHashMap[account]
        
        if accountHashMapValue == nil { return false }
        
        accountHashMap[account] = accountHashMapValue! + Double(money)
        
        return true
    }
    
    func withdraw(_ account: Int, _ money: Int) -> Bool {
        let accountHashMapValue = accountHashMap[account]
        let moneyInDouble = Double(money)
        
        if accountHashMapValue == nil { return false }
        if accountHashMapValue! < moneyInDouble { return false } // Not enough money
        
        accountHashMap[account] = accountHashMapValue! - moneyInDouble
        
        return true
    }
}

/**
 * Your Bank object will be instantiated and called as such:
 * let obj = Bank(balance)
 * let ret_1: Bool = obj.transfer(account1, account2, money)
 * let ret_2: Bool = obj.deposit(account, money)
 * let ret_3: Bool = obj.withdraw(account, money)
 */