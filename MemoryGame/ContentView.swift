import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CardGameViewModel()
    
    @State private var orientation = UIDevice.current.orientation // Detect the Device orientation
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var isLandscape: Bool {
        verticalSizeClass == .compact
    }
    
    var body: some View {
        GeometryReader { geometry in
            let columns = 4 // Columns
            let cardWidth = isLandscape ? geometry.size.width / 10 : geometry.size.width / 5 // Detect the Card Width
            let cardHeight = cardWidth * 1.5 // Detech the Card Height
            if isLandscape {
                HStack {
                    VStack {
                        // Display the List of Cards
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: columns), spacing: 15) {
                            ForEach(viewModel.cards) { card in
                                CardView(viewModel: viewModel, card: card)
                                    .frame(width: cardWidth, height: cardHeight)
                            }
                        }
                        .padding()
                    }
                    Spacer() // Space between the cards and score card
                    ControlPanel(viewModel: viewModel) // Score Card
                }
                .padding(.horizontal)
            } else {
                VStack(spacing: 20) {
                    Spacer() // Space at the top of the page
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 40), count: columns), spacing: 20) {
                        ForEach(viewModel.cards) { card in
                            CardView(viewModel: viewModel, card: card)
                                .frame(width: cardWidth, height: cardHeight)
                        }
                    }
                    .padding()
                    
                    ControlPanel(viewModel: viewModel) // Score & controls at the bottom
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}


#Preview {
    ContentView()
}
