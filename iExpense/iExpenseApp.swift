//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Ihor Sukhachov on 17.11.2025.
//
import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ExpenseItem.self)
        }
    }
}
