//
//  ContentView.swift
//  iExpense
//
//  Created by Ihor Sukhachov on 17.11.2025.
//
import SwiftUI


@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
    
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    
    var body: some View {
        NavigationStack {
            List() {
              //  Text()
                Section("Personal") {
                    let personal = expenses.items.filter { $0.type == "Personal" }
                    
                    ForEach(personal) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name).font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).foregroundStyle(expenseStyle(amount: item.amount))
                        }
                        
                    }.onDelete { offsets in
                        deleteItems(from: personal, at: offsets)
                    }
                }
                   // Spacer()
                 //   Text()
                    Section("Business") {
                        let business = expenses.items.filter { $0.type == "Business" }
                        
                        ForEach(business) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name).font(.headline)
                                    Text(item.type)
                                }
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).foregroundStyle(expenseStyle(amount: item.amount))
                            }
                            
                            }.onDelete { offsets in
                                deleteItems(from: business, at: offsets)
                        }
                    }
                }.navigationTitle("iExpense")
                .toolbar {
                    Button("Add expense", systemImage: "plus") {
                        showingAddExpense = true
                    }
                }
            }.sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            
        }
         
    }
//    func removeItems(at offsets: IndexSet) {
//        expenses.items.remove(atOffsets: offsets)
//    }
            
     func deleteItems(from list: [ExpenseItem], at offsets: IndexSet) {
                for index in offsets {
                    let item = list[index]
                    expenses.items.removeAll { $0.id == item.id }
                }
            }
    
    
    
    func expenseStyle(amount: Double) -> Color {
        if amount < 10 {
            return .green
        }
        else if amount < 100 {
            return .yellow
        }
        else {
            return .red
        }
    }
    
}

#Preview {
    ContentView()
}
