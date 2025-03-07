import SwiftUI

class CardGameViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var score = 0
    @Published var moves = 0
    @Published var gameOver = false
    
    private var firstSelectedCard: Card?
    private var secondSelectedCard: Card?
    
    let allEmojis = ["🦠", "🦞", "🚒", "🍇", "🍉", "🎎"]
    
    init() {
        startNewGame()
    }
    
    func startNewGame() {
        // Reset game state and shuffle emojis
        let emojiPairs = (allEmojis + allEmojis).shuffled()
        
        cards = emojiPairs.map { Card(emoji: $0) }
        score = 0
        moves = 0
        gameOver = false
        firstSelectedCard = nil
        secondSelectedCard = nil
        shuffleCards()
    }
    
    func selectCard(_ selectedCard: Card) {
        guard let index = cards.firstIndex(where: { $0.id == selectedCard.id }),
              !cards[index].isFaceUp, !cards[index].isMatched else { return }
        
        // ✅ If two cards are already selected and they do not match, close them
        if firstSelectedCard != nil && secondSelectedCard != nil {
            if firstSelectedCard!.emoji != secondSelectedCard!.emoji {
                if score > 0 {
                    score -= 1 // ✅ Immediately reduce score for a mismatch
                }
            }
            for i in cards.indices where !cards[i].isMatched {
                cards[i].isFaceUp = false
            }
            firstSelectedCard = nil
            secondSelectedCard = nil
        }
        
        // ✅ Flip the newly selected card
        cards[index].isFaceUp.toggle()
        
        if firstSelectedCard == nil {
            firstSelectedCard = cards[index]
        } else if secondSelectedCard == nil {
            secondSelectedCard = cards[index]
            moves += 1
            
            if firstSelectedCard!.emoji == secondSelectedCard!.emoji {
                // ✅ If both cards match, mark them as matched
                if let firstIndex = cards.firstIndex(where: { $0.id == firstSelectedCard!.id }) {
                    cards[firstIndex].isMatched = true
                }
                if let secondIndex = cards.firstIndex(where: { $0.id == secondSelectedCard!.id }) {
                    cards[secondIndex].isMatched = true
                }
                score += 2 // ✅ Award 2 points for a match
                firstSelectedCard = nil
                secondSelectedCard = nil
            }
        }
        
        // ✅ Check if game is over
        if cards.allSatisfy({ $0.isMatched }) {
            gameOver = true
        }
    }
    
    func shuffleCards() {
        cards.shuffle()
    }
}
