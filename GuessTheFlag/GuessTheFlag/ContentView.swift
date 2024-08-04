//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Abdulkerim Can on 4.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France","Germany", "Ireland","Italy","Monaco","Nigeria","Poland","Spain","UK","Ukraine","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionsCount = 1
    @State private var resettingGame = false
    var body: some View {
        ZStack {
            RadialGradient(
                stops: [.init(color: Color(red: 0.1,
                                           green: 0.2,
                                           blue: 0.46), location: 0.3),
                        .init(color: Color(red: 0.7,
                                           green: 0.1,
                                           blue: 0.26), location: 0.3)],
                center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap to select flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { index in
                        Button {
                            didTapFlagButton(number: index)
                        } label: {
                            Image(countries[index])
                                .clipShape(.capsule)
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Countinue", action: refresh)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game over!", isPresented: $resettingGame) {
            Button("Restart game", action: reset)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    private func didTapFlagButton(number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct! \(questionsCount)/8"
            score += 10
        } else {
            scoreTitle = "Wrong!! Thats the flag of \(countries[number])"
            
        }
        showingScore = true
        if questionsCount == 8 {
            resettingGame = true
        }
    }
    
    private func refresh() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionsCount += 1
    }
    
    private func reset() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionsCount = 0
        score = 0
    }
}

#Preview {
    ContentView()
}
