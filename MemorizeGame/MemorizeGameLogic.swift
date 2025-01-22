//
//  MemorizeGameLogic.swift
//  MemorizeGame
//
//  Created by Fernando Romo on 1/2/25.
//

import Foundation

                        //Because card content is now Equatable the static func below
                        //comparing the lhs and rhs cards are no longer needed
struct MemorizeGameLogic<CardContent> where CardContent: Equatable{
    //private(set) - access control
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        //add number of pairs of cards x 2 cards
        //creates duplicates of cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards){
            let content = cardContentFactory(pairIndex)
            //We use String interpolation here to add the index of the cards and give them unique ID's
            cards.append(Card(id: "\(pairIndex + 1)a", content: content))
            cards.append(Card(id: "\(pairIndex + 1)b", content: content))
        }
    }
    
    mutating func choose(_ card: Card){
        print("chose \(card)")
        
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()

    }
    
    func index(of card: Card) -> Int {
        for index in cards.indices{
            if cards[index].id == card.id{
                return index
            }
        }
        return 0 //FIXME: Bogus!
    }
    
    //Add mutating to know that this function is mutating/changing.
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible{
        //Equatable checks to see if a card == card and returns a boolean if it is true or false
//        static func == (lhs: Card, rhs: Card) -> Bool {
//            return lhs.isFaceUp == rhs.isFaceUp &&
//            lhs.isFaceUp == rhs.isMatched &&
//            lhs.content == rhs.content
//        }
        var id: String
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}
