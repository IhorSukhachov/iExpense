//
//  ContentView.swift
//  iExpense
//
//  Created by Ihor Sukhachov on 17.11.2025.
//
import Observation
import SwiftUI
/*
@Observable
class User {
    var firstName = "Ihor"
    var lastName = "Sukhachov"
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    var body: some View {
        VStack {
            Text("Second view, hello \(name)")
        }
        Button("Dismiss") {
            dismiss()
        }
    }
}
*/
struct ContentView: View {
    //   @State private var showingSheet = false
    //   @State private var user = User()
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id:\.self) {
                        Text("Row number: \($0)")
                    }
                    .onDelete(perform: removeRows)
                    
                }
                Button("Add number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                
                Button("Tap count \(tapCount)") {
                    tapCount += 1
                    UserDefaults.standard.set(tapCount, forKey: "Tap")
                }
            }
            .toolbar {
                EditButton()
            }
        }
        
    }
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
