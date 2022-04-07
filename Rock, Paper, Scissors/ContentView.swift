//
//  ContentView.swift
//  Rock, Paper, Scissors
//
//  Created by Dakota Riley on 4/7/22.
//
// Each turn of the game the app will randomly pick either rock, paper, or scissors.
// Each turn the app will alternate between prompting the player to win or lose.
// The player must then tap the correct move to win or lose the game.
// If they are correct they score a point; otherwise they lose a point.
// The game ends after 10 questions, at which point their score is shown.

import SwiftUI

struct GameButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.system(size: 50))
            .background(Color(red: 0.0, green: 0.07, blue: 0.26))
            .clipShape(Circle())
            .shadow(color: .secondary, radius: 5, x: 0, y: 0)
    }
}

extension View {
    func buttonStyle() -> some View {
        modifier(GameButton())
    }
}

struct ContentView: View {
    let moves = ["👊", "🖐", "✌️"]
    
    @State private var computerChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var questionCount = 1
    @State private var showingResults = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.0, green: 0.0, blue: 0.13), location: 0.3),
                .init(color: Color(red: 0.0, green: 0.37, blue: 0.49), location: 0.3)
            ],center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Rock, Paper, Scissors!")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding()
                VStack {
                    Text("Condition to meet")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                    if (shouldWin) {
                        Text("Win")
                            .font(.title.weight(.semibold))
                            .foregroundColor(.primary)
                    } else {
                        Text("Lose")
                            .font(.title.weight(.semibold))
                            .foregroundColor(.primary)
                    }
                    
                    
                    
                    Text(moves[computerChoice])
                        .padding(50)
                        .font(.system(size: 200))
                        .background(Color(red: 0.0, green: 0.58, blue: 0.78))
                        .clipShape(Circle())
                        .shadow(color: .secondary, radius: 5, x: 0, y: 0)
                    
                    HStack(spacing: 20){
                        ForEach(0..<3) { number in
                            Button(moves[number]) {
                                play(choice: number)
                            }
                            .buttonStyle()
                        }
                    }
                    .padding()
                }
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .frame(maxWidth: .infinity)
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .alert("Game Over", isPresented: $showingResults) {
            Button("Play Again", action: reset)
        } message: {
            Text("Your score was \(score).")
        }
    }
    
    
    
    func play(choice: Int) {
        let winningMoves = [1, 2, 0]
        let didWin: Bool
        
        if shouldWin {
            // Example: If computer selected rock and user selects paper, did set is true
            didWin = choice == winningMoves[computerChoice]
        } else {
            // Example: If the player selected scissors and computer selects rock, did set is false
            didWin = winningMoves[choice] == computerChoice
        }
        
        if didWin {
            score += 1
        } else {
            score -= 1
        }
        
        if questionCount == 10 {
            showingResults = true
        } else {
            computerChoice = Int.random(in: 0...2)
            shouldWin.toggle()
            questionCount += 1
        }
    }
    
    func reset() {
        computerChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        questionCount = 1
        score = 0
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
