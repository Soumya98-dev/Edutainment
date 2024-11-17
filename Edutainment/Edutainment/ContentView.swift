//
//  ContentView.swift
//  Edutainment
//
//  Created by Soumyadeep Chatterjee on 11/15/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var maxTable: Int
    @Binding var questionCount: Int
    var startGame: () -> Void

    var body: some View {
        VStack {
            Stepper(
                "Practice tables up to: \(maxTable)", value: $maxTable,
                in: 2...12
            )
            .padding()
            Picker("Number of questions", selection: $questionCount) {
                Text("5").tag(5)
                Text("10").tag(10)
                Text("15").tag(15)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Button("Start Game") {
                startGame()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }

    }
}

struct ContentView: View {
    @State private var isGameActive = false
    @State private var maxTable = 12
    @State private var questionCount = 5

    var body: some View {
        if isGameActive {
            Text("Game screen")
        } else {
            SettingsView(
                maxTable: $maxTable, questionCount: $questionCount,
                startGame: {
                    isGameActive = true
                })
        }
    }
}

#Preview {
    ContentView()
}
