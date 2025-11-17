//
//  ContentView.swift
//  iExpense
//
//  Created by Ihor Sukhachov on 17.11.2025.
//

import SwiftUI

@Observable
class User {
    var firstName = "Ihor"
    var lastName = "Sukhachov"
}
struct ContentView: View {
    @State private var user = User()
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("Firstname", text: $user.firstName)
            TextField("Lastname", text: $user.lastName)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
