import SwiftUI

struct CardFront: View {
    let emoji: String
    
    var body: some View {
        // Rounded corners to the card
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .overlay(
                Text(emoji)
                    .font(.largeTitle)
            )
            .shadow(radius: 5)
    }
}
