import SwiftUI

struct ControlPanel: View {
    @ObservedObject var viewModel: CardGameViewModel
    
    var body: some View {
        VStack {
            // Score Text Field
            HStack {
                Text("Score: \(viewModel.score)")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
                // Moves Text Field
                Text("Moves: \(viewModel.moves)")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding(.horizontal)
            // New game Button
            HStack {
                Button("New Game") {
                    withAnimation {
                        viewModel.startNewGame()
                    }
                }
                .padding(.vertical, 10)
                .background(Color.white)
                .foregroundColor(.blue)
                .cornerRadius(8)
                // Shuffle Button
                Button("Shuffle") {
                    withAnimation {
                        viewModel.shuffleCards()
                    }
                }
                .padding(.vertical, 10)
                .background(Color.white)
                .foregroundColor(.blue)
                .cornerRadius(8)
            }
            if viewModel.gameOver {
                Text("Game Over!")
                    .font(.title)
                    .foregroundColor(.green)
                    .padding(.bottom, 5)
            }
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}
