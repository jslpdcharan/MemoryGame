import SwiftUI

struct CardView: View {
    @ObservedObject var viewModel: CardGameViewModel
    let card: Card
    @State private var dragAmount = CGSize.zero
    @State private var rotationAngle: Double = 0

    var body: some View {
        ZStack {
            if card.isFaceUp {
                CardFront(emoji: card.emoji)
            } else {
                CardBack()
            }
        }
        .frame(width: 80, height: 120)
        .rotation3DEffect(.degrees(card.isFaceUp ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .rotationEffect(.degrees(rotationAngle)) // rotate card effect
        .opacity(card.isMatched ? 0.5 : 1.0) // Change the matched cards color
        .gesture(
            // On Single Tap Add a Tap Gesture
            TapGesture(count: 1)
                .onEnded {
                    withAnimation {
                        rotationAngle = 360
                    }
                    
                    // Reset rotation after 1 second
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            rotationAngle = 0
                        }
                    }
                }
        )
        .gesture(
            // On Double Tap open the card
            TapGesture(count: 2)
                .onEnded {
                    withAnimation {
                        viewModel.selectCard(card)
                    }
                }
        )
        // Drag Gesture for the Cards in the App
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    withAnimation {
                        dragAmount = .zero // Reset the Card to the original position
                    }
                }
        )
        .offset(dragAmount)
        .shadow(radius: 5)
    }
}
