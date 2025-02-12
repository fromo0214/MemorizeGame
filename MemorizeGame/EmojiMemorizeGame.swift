import SwiftUI

//View Model
class EmojiMemorizeGame: ObservableObject {
    
    struct Theme {
        let name: String
        let emojis: [String]
        let cardColor: Color
    }
    
    //need to keep count of the score of a player when choosing cardsx`xx
    
    struct Player{
        var score: Int = 0
        var seenCards: Set<String> = []
    }
    
    private static let themes: [Theme] = [
        .init(name: "Animals", emojis: ["🐶", "🐭", "🐰", "🐻", "🐨", "🐸", "🐵"], cardColor: .blue),
        .init(name: "Food", emojis: ["🍎", "🍊", "🍋", "🍌", "🍉", "🍇", "🍔"], cardColor: .red),
        .init(name: "Halloween", emojis: ["🎃", "👻", "🕷", "🦇", "🧙‍♀️", "🕸", "👺"], cardColor: .orange),
        .init(name: "Flags", emojis: ["🇮🇹", "🇩🇪", "🇪🇸", "🇫🇷", "🇬🇧", "🇩🇰", "🇺🇸"], cardColor: .yellow)
    ]
    @Published var selectedTheme: Theme
    @Published private var model: MemorizeGameLogic<String>
    @Published private(set) var player = Player()
    
    // MARK: - Initialization
    init() {
        let theme = EmojiMemorizeGame.themes.randomElement()!
        self.selectedTheme = theme
        self.model = EmojiMemorizeGame.createMemoryGame(with: theme)
    }
    
    // MARK: - Create Memory Game
    private static func createMemoryGame(with theme: Theme) -> MemorizeGameLogic<String> {
        print("Creating game with theme:", theme.name) // ✅ Debug print
        
        return MemorizeGameLogic(numberOfPairsOfCards: theme.emojis.count) { pairIndex in
            theme.emojis[pairIndex % theme.emojis.count]
            
//            if theme.emojis.indices.contains(pairIndex) {
//                print("Card content:", theme.emojis[pairIndex]) // ✅ Debug print
//                return theme.emojis[pairIndex]
//            } else {
//                return "⁉️"
//            }
        }
    }

    
    // MARK: - Public Interface
    var cards: [MemorizeGameLogic<String>.Card] {
        return model.cards
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        shuffle()
        selectedTheme = EmojiMemorizeGame.themes.randomElement()!// ✅ Pick a new theme
        model = EmojiMemorizeGame.createMemoryGame(with: selectedTheme)// ✅ Create a new game with the new theme
        player = Player()
    }
    
    func choose(_ card: MemorizeGameLogic<String>.Card) {
        flipCard(card)
    }
    
    func flipCard(_ card: MemorizeGameLogic<String>.Card){
        
        
        if player.seenCards.contains(card.id) && !card.isFaceUp{
            player.score -= 1
        }else{
            player.seenCards.insert(card.id)
            
            if let potentialMatchIndex = model.indexOfTheOneAndOnlyFaceUpCard, model.cards[potentialMatchIndex].content == card.content{
                player.score += 2
            }
        }
        
        
        model.choose(card)
    }
}
