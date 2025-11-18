//
//  ContentView.swift
//  iExpense
//
//  Created by Ihor Sukhachov on 17.11.2025.
//
import SwiftUI

struct ExpenseItem: Identifiable {
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
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }.onDelete(perform: removeItems)
            }.navigationTitle("iExpense")
                .toolbar {
                    Button("Add expense", systemImage: "plus") {
                        
                    }
                }
        }.sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
         
    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
