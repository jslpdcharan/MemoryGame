import SwiftUI

// Card Structure 
struct Card: Identifiable {
    let id = UUID()
    var isFaceUp = false
    var isMatched = false
    let emoji: String
    var position: CGFloat = 0
}
