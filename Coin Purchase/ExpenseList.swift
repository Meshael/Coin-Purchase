//
//  Expenselist.swift
//  Coin Purchase
//
//  Created by Mashael Alharbi on 18/02/2023.
//

import Foundation

class ExpenseList: ObservableObject {
    
    @Published private (set) var totalCost = 0.0  // <-- here

    @Published var itemList = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(itemList) {
                UserDefaults.standard.set(encoded, forKey: "Things")
            }
            totalCost = itemList.map{ $0.amount }.reduce(0.0, { $0 + $1 }) // <-- here
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Things") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                itemList = decodedItems
                return
            }
        }
        itemList = []
    }
    
    struct ExpenseItem: Identifiable, Codable {
        var id = UUID()
        let item: String
        let amount: Double
    }
}
