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
struct User: Codable {
    let firstName: String
    let lastName: String
}

struct ContentView: View {
    //   @State private var showingSheet = false
    //   @State private var user = User()
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    @AppStorage("tapCount") private var tapCount = 0
    
    @State private var user = User(firstName: "Ihor", lastName: "Sukhachov")
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("save user") {
                    let encoder = JSONEncoder()
                    
                    if let data = try? encoder.encode(user) {
                        UserDefaults.standard.set(data, forKey: "userData")
                    }
                }
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
