//
//  MemorizeGameLogic.swift
//  MemorizeGame
//
//  Created by Fernando Romo on 1/2/25.
//
// Model
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
            print("Initializing card with content:", content)
            
            //We use String interpolation here to add the index of the cards and give them unique ID's
            cards.append(Card(id: "\(pairIndex + 1)a", content: content))
            cards.append(Card(id: "\(pairIndex + 1)b", content: content))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int?{
        //
        get{ cards.indices.filter { index in cards[index].isFaceUp }.only
//            for index in cards.indices{
//                if cards[index].isFaceUp{
//                    faceUpCardIndices.append(index)
//                }
//            }
//            if faceUpCardIndices.count == 1{
//                return faceUpCardIndices.first
        }
        
        set{ cards.indices.forEach{ cards[$0].isFaceUp = (newValue == $0)}
//            for index in cards.indices {
//                if index == newValue{
//                    cards[index].isFaceUp = true
//                }else{
//                    cards[index].isFaceUp = false
//                }
//            }
        }
    }
    
    
    
    mutating func choose(_ card: Card){
        print("chose \(card)")
        
        //Using if let uses Optional Int because we might not find an index for a card
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            //if the card is face down and is not matched then it will allow you to flip the card
            if (!cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched){
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                    // Reset `indexOfTheOneAndOnlyFaceUpCard` since we've now processed a match or mismatch.
                }else{
                    // No cards are currently face up (not in the middle of a match attempt).
                    // Flip all cards face down to ensure only one card is face up.
//                    for index in cards.indices{
//                        cards[index].isFaceUp = false
//                    }
                    // Update `indexOfTheOneAndOnlyFaceUpCard` to the current chosen card index,
                    // indicating this is now the only face-up card.
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
      
                //Flips the chosen card face up
                cards[chosenIndex].isFaceUp = true
            }
        }

    }
//    
//    private func index(of card: Card) -> Int? {
//        for index in cards.indices{
//            if cards[index].id == card.id{
//                return index
//            }
//        }
//        return nil
//    }
    
    //Add mutating to know that this function is mutating/changing.
    mutating func shuffle(){
        cards.shuffle()
//        print(cards)
    }
    
    mutating func newGame(){
        shuffle()
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
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

    

//Adds a computer property to all arrays
//The property returns the only element in the array if the array has exactly one element
//if the array has zero or morre than one element, it returns nil
extension Array{
    var only: Element? {
        return count == 1 ? first : nil
    }
}
