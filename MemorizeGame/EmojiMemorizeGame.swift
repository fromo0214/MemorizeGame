import SwiftUI

//View Model
class EmojiMemorizeGame: ObservableObject {
    
    struct Theme {
        let name: String
        let emojis: [String]
        let cardColor: String
    }
    
    private static let themes: [Theme] = [
        .init(name: "Animals", emojis: ["🐶", "🐭", "🐰", "🐻", "🐨", "🐸", "🐵"], cardColor: "blue"),
        .init(name: "Food", emojis: ["🍎", "🍊", "🍋", "🍌", "🍉", "🍇"], cardColor: "red"),
        .init(name: "Halloween", emojis: ["🎃", "👻", "🕷", "🦇", "🧙‍♀️", "🕸"], cardColor: "orange"),
        .init(name: "Flags", emojis: ["🇮🇹", "🇩🇪", "🇪🇸", "🇫🇷", "🇬🇧", "🇩🇰"], cardColor: "yellow")
    ]
    
    @Published var selectedTheme: Theme
    @Published private var model: MemorizeGameLogic<String> // ✅ No initialization here
    
    // MARK: - Initialization
    init() {
        let theme = EmojiMemorizeGame.themes.randomElement()!  // ✅ Step 1: Pick a random theme
        self.selectedTheme = theme                             // ✅ Step 2: Assign the theme
        self.model = EmojiMemorizeGame.createMemoryGame(with: theme)             // ✅ Step 3: Initialize model using the theme
    }
    
    // MARK: - Create Memory Game
    private static func createMemoryGame(with theme: Theme) -> MemorizeGameLogic<String> {
        print("Creating game with theme:", theme.name) // ✅ Debug print
        return MemorizeGameLogic(numberOfPairsOfCards: theme.emojis.count) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                print("Card content:", theme.emojis[pairIndex]) // ✅ Debug print
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
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
    }
    
    func choose(_ card: MemorizeGameLogic<String>.Card) {
        model.choose(card)
    }
}
