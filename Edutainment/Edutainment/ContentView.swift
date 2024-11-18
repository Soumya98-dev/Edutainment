//
//  ContentView.swift
//  Edutainment
//
//  Created by Soumyadeep Chatterjee on 11/15/24.
//

import SwiftUI

struct Question {
    let text: String
    let answer: Int
}

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
    @State private var questions = [Question]()
    @State private var currentQuestionIndex = 0
    @State private var score = 0

    var body: some View {
        if isGameActive {
            Text("Game screen")
        } else {
            SettingsView(
                maxTable: $maxTable, questionCount: $questionCount,
                startGame: {
                    startGame()
                })
        }
    }

    func generateQuestions(upTo maxTable: Int, count: Int) -> [Question] {
        var questions = [Question]()
        for _ in 1...count {
            let num1 = Int.random(in: 2...maxTable)
            let num2 = Int.random(in: 2...maxTable)
            let questionText = "What is \(num1) * \(num2)?"
            let answer = num1 * num2
            questions.append(Question(text: questionText, answer: answer))

        }
        return questions
    }

    func startGame() {
        questions = generateQuestions(upTo: maxTable, count: questionCount)
        print(questions)
        isGameActive = true
    }
}

struct GameView: View {
    let questions: [Question]
    var body: some View {
        VStack {

        }
    }
}

#Preview {
    ContentView()
}
