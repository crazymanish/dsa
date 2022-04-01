//
//  ViewController+Challenge74.swift
//  HashTable
//
//  Created by Manish Rathi on 01/04/2022.
//

import Foundation
/*
 1418. Display Table of Food Orders in a Restaurant
 https://leetcode.com/problems/display-table-of-food-orders-in-a-restaurant/
 Given the array orders, which represents the orders that customers have done in a restaurant. More specifically orders[i]=[customerNamei,tableNumberi,foodItemi] where customerNamei is the name of the customer, tableNumberi is the table customer sit at, and foodItemi is the item customer orders.

 Return the restaurant's “display table”. The “display table” is a table whose row entries denote how many of each food item each table ordered. The first column is the table number and the remaining columns correspond to each food item in alphabetical order. The first row should be a header whose first column is “Table”, followed by the names of the food items. Note that the customer names are not part of the table. Additionally, the rows should be sorted in numerically increasing order.

 Example 1:
 Input: orders = [["David","3","Ceviche"],["Corina","10","Beef Burrito"],["David","3","Fried Chicken"],["Carla","5","Water"],["Carla","5","Ceviche"],["Rous","3","Ceviche"]]
 Output: [["Table","Beef Burrito","Ceviche","Fried Chicken","Water"],["3","0","2","1","0"],["5","0","1","0","1"],["10","1","0","0","0"]]
 Explanation:
 The displaying table looks like:
 Table,Beef Burrito,Ceviche,Fried Chicken,Water
 3    ,0           ,2      ,1            ,0
 5    ,0           ,1      ,0            ,1
 10   ,1           ,0      ,0            ,0
 For the table 3: David orders "Ceviche" and "Fried Chicken", and Rous orders "Ceviche".
 For the table 5: Carla orders "Water" and "Ceviche".
 For the table 10: Corina orders "Beef Burrito".

 Example 2:
 Input: orders = [["James","12","Fried Chicken"],["Ratesh","12","Fried Chicken"],["Amadeus","12","Fried Chicken"],["Adam","1","Canadian Waffles"],["Brianna","1","Canadian Waffles"]]
 Output: [["Table","Canadian Waffles","Fried Chicken"],["1","2","0"],["12","0","3"]]
 Explanation:
 For the table 1: Adam and Brianna order "Canadian Waffles".
 For the table 12: James, Ratesh and Amadeus order "Fried Chicken".

 Example 3:
 Input: orders = [["Laura","2","Bean Burrito"],["Jhon","2","Beef Burrito"],["Melissa","2","Soda"]]
 Output: [["Table","Bean Burrito","Beef Burrito","Soda"],["2","1","1","1"]]
 */

extension ViewController {
    func solve74() {
        print("Setting up Challenge74 input!")

        let input = [["David","3","Ceviche"],["Corina","10","Beef Burrito"],["David","3","Fried Chicken"],["Carla","5","Water"],["Carla","5","Ceviche"],["Rous","3","Ceviche"]]
        print("Input: \(input)")
        let output = Solution().displayTable(input)
        print("Output: \(output)")
    }
}

private class Solution {
    func displayTable(_ orders: [[String]]) -> [[String]] {
        var tables: Set<Int> = []
        var foodItems: Set<String> = []
        var hashMap: [Int : [String : Int]] = [:]

        for order in orders {
            let tableNumber = Int(order[1])!
            let foodItem = order[2]

            tables.insert(tableNumber)
            foodItems.insert(foodItem)

            var hashMapValue = hashMap[tableNumber] ?? [:]
            let footItemCount = hashMapValue[foodItem] ?? 0
            hashMapValue[foodItem] = footItemCount + 1
            hashMap[tableNumber] = hashMapValue
        }

        var output: [[String]] = []

        var outputRow: [String] = ["Table"]
        for foodItem in foodItems.sorted() {
            outputRow.append(foodItem)
        }

        output.append(outputRow)

        for table in tables.sorted() {
            let foodHashMap = hashMap[table]!
            var outputRow: [String] = ["\(table)"]
            for foodItem in foodItems.sorted() {
                let foodValue = foodHashMap[foodItem] ?? 0
                outputRow.append("\(foodValue)")
            }
            output.append(outputRow)
        }

        return output
    }
}
