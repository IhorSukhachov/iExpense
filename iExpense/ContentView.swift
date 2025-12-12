//
//  ContentView.swift
//  iExpense
//
//  Created by Ihor Sukhachov on 17.11.2025.
//
import SwiftData
import SwiftUI


struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\ExpenseItem.name, order: .forward)])
    private var itemsSortedByName: [ExpenseItem]
    
    @Query(sort: [SortDescriptor(\ExpenseItem.amount, order: .reverse)])
    private var itemsSortedByAmount: [ExpenseItem]
    
    @State private var sortByName: Bool = true
    
    @State private var filter: String = "All"
    private var items: [ExpenseItem] {
        let base = sortByName ? itemsSortedByName : itemsSortedByAmount
        switch filter {
        case "Personal":
            return base.filter { $0.type == "Personal" }
        case "Business":
            return base.filter { $0.type == "Business" }
        default:
            return base
        }
    }
    
    
    @State private var showingAddExpense = false
    
    
    
    var body: some View {
        NavigationStack {
            List() {
                //  Text()
                //                Section("Personal") {
                //  let personal = items.filter { $0.type == "Personal" }
                
                ForEach(items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name).font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).foregroundStyle(expenseStyle(amount: item.amount))
                    }
                    
                }.onDelete { offsets in
                    deleteItems(from: items, at: offsets)
                }
                //                }
                // Spacer()
                //   Text()
                //                    Section("Business") {
                //                        let business = items.filter { $0.type == "Business" }
                //
                //                        ForEach(business) { item in
                //                            HStack {
                //                                VStack(alignment: .leading) {
                //                                    Text(item.name).font(.headline)
                //                                    Text(item.type)
                //                                }
                //                                Spacer()
                //
                //                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).foregroundStyle(expenseStyle(amount: item.amount))
                //                            }
                //
                //                            }.onDelete { offsets in
                //                                deleteItems(from: business, at: offsets)
                //                        }
                //                    }
            }.navigationTitle("iExpense")
                .toolbar {
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortByName) {
                            Text("Sort by name").tag(true)
                            Text("Sort by amount").tag(false)
                        }
                    }
                    
                    Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                        Picker("Filter", selection: $filter) {
                            Text("All").tag("All")
                            Text("Personal").tag("Personal")
                            Text("Business").tag("Business")
                        }
                    }
                    
                    Button("Add expense", systemImage: "plus") {
                        showingAddExpense = true
                    }
                }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView()
            
        }
        
    }
    //    func removeItems(at offsets: IndexSet) {
    //        expenses.items.remove(atOffsets: offsets)
    //    }
    
    func deleteItems(from list: [ExpenseItem], at offsets: IndexSet) {
        for index in offsets {
            let item = list[index]
            modelContext.delete(item)
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
