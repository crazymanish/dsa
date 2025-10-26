class Bank {

    typealias AccountNumber = Int
    typealias Balance = Int

    // Stores account number and corresponding balance
    var accountHashMap: [AccountNumber : Balance] = [:]

    // Time Complexity: O(n)
    // Space Complexity: O(n)
    // where n = number of accounts
    init(_ balance: [Int]) {
        for i in 0..<balance.count {
            accountHashMap[i+1] = balance[i]
        }
    }

    // Transfers money from account1 to account2 if valid
    // Time Complexity: O(1)  → Dictionary lookups and updates are constant time
    // Space Complexity: O(1)
    func transfer(_ account1: Int, _ account2: Int, _ money: Int) -> Bool {
        let account1HashMapValue = accountHashMap[account1]
        let account2HashMapValue = accountHashMap[account2]

        // Check if both accounts exist
        if account1HashMapValue == nil || account2HashMapValue == nil { return false }

        // Check if sender has enough balance
        if account1HashMapValue! < money { return false }

        // If same account, no transfer needed
        if account1 == account2 { return true }

        // Update balances
        accountHashMap[account1] = account1HashMapValue! - money
        accountHashMap[account2] = account2HashMapValue! + money

        return true
    }

    // Deposits money into an account
    // Time Complexity: O(1)
    // Space Complexity: O(1)
    func deposit(_ account: Int, _ money: Int) -> Bool {
        let accountHashMapValue = accountHashMap[account]

        // Account doesn't exist
        if accountHashMapValue == nil { return false }

        // Add funds
        accountHashMap[account] = accountHashMapValue! + money

        return true
    }

    // Withdraws money from an account if sufficient balance
    // Time Complexity: O(1)
    // Space Complexity: O(1)
    func withdraw(_ account: Int, _ money: Int) -> Bool {
        let accountHashMapValue = accountHashMap[account]

        // Account doesn't exist
        if accountHashMapValue == nil { return false }

        // Not enough funds
        if accountHashMapValue! < money { return false }

        // Deduct amount
        accountHashMap[account] = accountHashMapValue! - money

        return true
    }
}

/**
 * Your Bank object will be instantiated and called as such:
 * let obj = Bank(balance)
 * let ret_1: Bool = obj.transfer(fromAccount, toAccount, amount)
 * let ret_2: Bool = obj.deposit(account, amount)
 * let ret_3: Bool = obj.withdraw(account, amount)
 */