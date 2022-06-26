//
//  EmojiMemoryGameView.swift
//  View
//  Memorize
//
//  Created by Madison Ranf on 10/5/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @Environment(\.colorScheme) var colorScheme
    /// Initialize this in the MemorizeApp (@main) file by passing in the pointer to the vm as the viewModel
    /// The vm is observed for changes so the view will re-render anytime the model is changed
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.title)
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                cardView(for: card)
            })
            .foregroundColor(.orange)
            .padding(.horizontal)
            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
        }
    }
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        }
    }


struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        return Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    }
}

//MARK: - Preview pane
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        Group {
            EmojiMemoryGameView(game: game)
                .previewDevice("iPhone 11 Pro")
                .preferredColorScheme(.dark)
            EmojiMemoryGameView(game: game)
                .previewDevice("iPhone 11 Pro")
                .preferredColorScheme(.light)
        }
    }
}
}
