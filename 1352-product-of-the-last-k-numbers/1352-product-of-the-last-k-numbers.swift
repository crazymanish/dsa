class ProductOfNumbers {
    private var prefixProducts = [Int]() // Array to store prefix products

    func add(_ num: Int) {
        if num == 0 {
            prefixProducts = [] // Reset if num is 0
        } else {
            let newProduct = (prefixProducts.last ?? 1) * num // Calculate the new prefix product
            prefixProducts.append(newProduct) // Append the new prefix product
        }
    }

    func getProduct(_ k: Int) -> Int {
        let count = prefixProducts.count // Store count for better readability

        if k > count {
            return 0
        } else if k == count {
            return prefixProducts.last ?? 0 // Handle empty array case (though unlikely)
        } else {
            return (prefixProducts.last ?? 0) / prefixProducts[count - 1 - k] // Handle empty array case
        }
    }
}

/**
 * Your ProductOfNumbers object will be instantiated and called as such:
 * let obj = ProductOfNumbers()
 * obj.add(num)
 * let ret_2: Int = obj.getProduct(k)
 */