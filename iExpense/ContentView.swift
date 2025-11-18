//
//  ContentView.swift
//  iExpense
//
//  Created by Ihor Sukhachov on 17.11.2025.
//
import SwiftUI

struct ExpenseItem {
    let id = UUID()
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
                ForEach(expenses.items, id: \.id) { item in
                    Text(item.name)
                }.onDelete(perform: removeItems)
            }.navigationTitle("iExpense")
                .toolbar {
                    Button("Add expense", systemImage: "plus") {
                        let newItem = ExpenseItem(name: "New expense", type: "Food", amount: 100.00)
                        expenses.items.append(newItem)
                    }
                }
        }
         
    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
