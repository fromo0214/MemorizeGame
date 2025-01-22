//
//  EmojiMemorizeGame.swift
//  MemorizeGame
//
//  Created by Fernando Romo on 1/2/25.
//
//View Model
import SwiftUI


class EmojiMemorizeGame: ObservableObject{
    private static let emojis = ["🐶", "🐭", "🐰", "🐻", "🐨", "🐸", "🐵"]
    
    private static func createMemoryGame() -> MemorizeGameLogic<String>{
        return MemorizeGameLogic(numberOfPairsOfCards: 7) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            }else{
                return "⁉️"
            }
        }
    }
    
    //We add this var when something changed
    // var objectWillChange: ObservableObjectPublisher
    
    //to mark any var to be changed add @Published
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemorizeGameLogic<String>.Card>{
        return model.cards
    }
    //This creates a divider/bookmark that displays to navigate through your code
    // MARK: -Inents
    
    func shuffle(){
        model.shuffle()
//        objectWillChange.send()
    }
    
    func choose(_ card: MemorizeGameLogic<String>.Card){
        model.choose(card)
    }
}

