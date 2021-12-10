//
//  EmojiMemoryGameView.swift
//  View
//  Memorize
//
//  Created by Rob Ranf on 10/5/21.
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
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65.0))]) {
                    ForEach(game.cards) {card in
                        CardView(card: card)
                            .aspectRatio(2.0/2.75, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.orange)
//            Spacer()
//            HStack {
//                VStack {
//                    halloweenButton
//                    Text("Halloween").font(.caption).foregroundColor(.accentColor)
//                }
//                Spacer()
//                VStack {
//                    holidaysButton
//                    Text("Holidays").font(.caption).foregroundColor(.accentColor)
//                }
//                Spacer()
//                VStack {
//                    flagsButton
//                    Text("Flags").font(.caption).foregroundColor(.accentColor)
//                }
//            }
            .padding(.horizontal)
            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
        }
        .padding()
    }
    
    // -TODO: The cards need to load in random order
    
//    var halloweenButton: some View {
//        Button(action: {
//            emojiTheme = 0
//        }, label: {
//            Image(systemName: "moon")
//        })
//    }
//
//    var holidaysButton: some View {
//        Button(action: {
//            emojiTheme = 1
//        }, label: {
//            Image(systemName: "snowflake")
//        })
//    }
//
//    var flagsButton: some View {
//        Button(action: {
//            emojiTheme = 2
//        }, label: {
//            Image(systemName: "flag")
//        })
//    }
    
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
            static let cornerRadius: CGFloat = 25
            static let lineWidth: CGFloat = 3
            static let fontScale: CGFloat = 0.8
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
