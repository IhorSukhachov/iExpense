//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Ihor Sukhachov on 12.12.2025.
//
import SwiftData
import Foundation

@Model
class ExpenseItem: Identifiable {
    var id: UUID = UUID()
    var name: String
    var type: String
    var amount: Double

    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}
