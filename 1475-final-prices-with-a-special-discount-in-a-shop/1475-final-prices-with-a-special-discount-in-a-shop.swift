class Solution {
    func finalPrices(_ prices: [Int]) -> [Int] {
        var prices = prices
        var stack = [Int]()
    
        for i in 0..<prices.count {
            while !stack.isEmpty && prices[i] <= prices[stack.last!] {
                let index = stack.removeLast()
                prices[index] -= prices[i]
            }
            stack.append(i)
        }
    
        return prices
    }
}

/*
Explanation
Initialization:

Initialize an empty stack to store indices.
Loop Through Prices:

Iterate through the prices array using a loop with index i.
Stack Operations:

While the stack is not empty and the current price is less than or equal to the price at the index stored at the top of the stack:
Pop the index from the stack.
Update the price at that index with the discounted price by subtracting the current price from it.
Push Current Index:

Push the current index i onto the stack.
Return Result:

After processing all prices, return the updated prices array.
Example Walkthrough
For the input prices = [8, 4, 6, 2, 3]:

First Item (8):

Stack: [0]
Second Item (4):

Current price (4) is less than price at index 0 (8).
Update price at index 0: 8 - 4 = 4.
Stack: []
Push index 1 onto the stack.
Stack: [1]
Third Item (6):

Stack: [1, 2]
Fourth Item (2):

Current price (2) is less than price at index 2 (6).
Update price at index 2: 6 - 2 = 4.
Stack: [1]
Current price (2) is less than price at index 1 (4).
Update price at index 1: 4 - 2 = 2.
Stack: []
Push index 3 onto the stack.
Stack: [3]
Fifth Item (3):

Stack: [3, 4]
The final prices array is [4, 2, 4, 2, 3].
*/