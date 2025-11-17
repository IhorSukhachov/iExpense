//
//  ContentView.swift
//  iExpense
//
//  Created by Ihor Sukhachov on 17.11.2025.
//
import Observation
import SwiftUI

@Observable
class User {
    var firstName = "Ihor"
    var lastName = "Sukhachov"
}

struct SecondView: View {
    let name: String
    var body: some View {
        VStack {
            Text("Second view, hello \(name)")
        }
    }
}

struct ContentView: View {
    @State private var showingSheet = false
    
    
    @State private var user = User()
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("Firstname", text: $user.firstName)
            TextField("Lastname", text: $user.lastName)
        }
        .padding()
        Button("Show sheet") {
            showingSheet.toggle()
        }.sheet(isPresented: $showingSheet) {
           SecondView(name: "Frodo")
        }
    }
}

#Preview {
    ContentView()
}
