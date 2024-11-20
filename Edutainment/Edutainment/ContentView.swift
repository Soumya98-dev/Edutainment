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
    @State private var questions: [Question] = []
    @State private var currentQuestionIndex: Int = 0
    @State private var score: Int = 0
    @State private var userAnswer: String = ""

    var body: some View {
        if isGameActive {
            Text("Game screen")
            GameView(
                questions: questions,
                currentQuestionIndex: $currentQuestionIndex,
                score: $score,
                userAnswer: $userAnswer,
                onGameOver: {
                    isGameActive = false
                }
            )
        } else {
            SettingsView(
                maxTable: $maxTable, questionCount: $questionCount,
                startGame: {
                    questions = generateQuestions(
                        upTo: maxTable, count: questionCount)
                    currentQuestionIndex = 0
                    score = 0
                    userAnswer = ""
                    isGameActive = true

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
    @Binding var currentQuestionIndex: Int
    @Binding var score: Int
    @Binding var userAnswer: String

    var onGameOver: () -> Void

    var body: some View {
        VStack {
            Text("Question \(questions[currentQuestionIndex].text)")
                .font(.title)
                .padding()
            TextField("Enter your answer", text: $userAnswer)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Submit answer") {
                checkAnswer()
            }
            .buttonStyle(.borderedProminent)
            .padding()

            Text("Score: \(score)")
                .font(.headline)
                .padding()

            Spacer()

        }
        .padding()
    }

    private func checkAnswer() {
        if let userAnswerInt = Int(userAnswer),
            userAnswerInt == questions[currentQuestionIndex].answer
        {
            score = score + 1
        }

        userAnswer = ""

        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex = currentQuestionIndex + 1
        } else {
            onGameOver()
        }
    }
}




#Preview {
    ContentView()
}
