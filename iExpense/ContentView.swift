//
//  ContentView.swift
//  iExpense
//
//  Created by Ihor Sukhachov on 17.11.2025.
//
import SwiftUI

struct ExpenseItem {
    let name: String
    let type: String
    let amount: Double
    
    
}

@Observable
class Expenses {
    var items = [ExpenseItem]()
    
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items, id: \.name) { item in
                    Text(item.name)
                }
            }.navigationTitle("iExpense")
                .toolbar {
                    
                }
        }
         
    }
    
}

#Preview {
    ContentView()
}
