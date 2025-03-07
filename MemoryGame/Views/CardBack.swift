import SwiftUI

struct CardBack: View {
    var body: some View {
        // Rounded Corners to the card
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue)
            .overlay(
                StripedPattern()
                    .opacity(0.3)
            )
            .shadow(radius: 5)
    }
}

// white stripe pattern on the card
struct StripedPattern: View {
    var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                let spacing: CGFloat = 10
                
                for x in stride(from: 0, to: size.width, by: spacing) {
                    var path = Path()
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: size.height))
                    context.stroke(path, with: .color(.white), lineWidth: 2)
                }
            }
        }
    }
}
