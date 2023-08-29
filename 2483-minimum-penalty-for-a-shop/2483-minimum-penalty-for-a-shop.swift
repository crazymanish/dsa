class Solution {
    func bestClosingTime(_ customers: String) -> Int {
        let customers = Array(customers)
        var earliestHour  = 0    
        var yCustomers = customers.filter { $0 == "Y" }.count
        var minimumPenalty = yCustomers
    
        for i in 0..<customers.count {
            if customers[i] == "Y" {
                minimumPenalty -= 1
                
                if minimumPenalty < yCustomers {
                    yCustomers = minimumPenalty
                    earliestHour = i + 1
                }
                
            } else {
                minimumPenalty += 1
            }
        }
        
        return earliestHour    
    }
}