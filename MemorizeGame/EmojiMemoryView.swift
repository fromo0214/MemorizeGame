//
//  EmojiMemoryView.swift
//  MemorizeGame
//
//  Created by Fernando Romo on 12/14/24.
//
//View
import SwiftUI

struct EmojiMemoryView: View {
    //these variables are structs but view is not
//    var i: Int
//    var b: String
    //@ObservedObject means if something has changed than redraw it.
    //@StateObject: Reactive UI
    @ObservedObject var viewModel: EmojiMemorizeGame
    
//    let emojis: [String] = ["🐶", "🐶", "🐭", "🐭", "🐰", "🐰", "🐻", "🐻", "🐨", "🐨"]
//    @State var cardCount : Int = 5
    
    //to behave like a view you need var body
    //"some View" means look for a view and if you find it return it
    var body: some View {

        //Vstack stands for vertical stack
//            Text("Memorize!").font(.largeTitle)
        VStack{
            Text("Theme: " + viewModel.selectedTheme.name).font(.title)
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
                //            Spacer()
                //            cardCountAdjusters
            }
//            Button("Shuffle"){
//                viewModel.shuffle()
//            }.font(.largeTitle)
            Button("New Game"){
                viewModel.newGame()
                viewModel.shuffle()
            }.font(.largeTitle)
        }
        //ZStack is towards the user, basically up and down
        //everything below the VStack scope will be applied to everything in the body scope
        .padding()
    }
    
//    var cardCountAdjusters: some View{
//        //H stack stands for horizontal stack, child views are placed side by side.
//        HStack{
////            cardAdder
//            Spacer()
//            theme1
//            Spacer()
//            theme2
//            Spacer()
//            theme3
//            //creates space in between the buttons
//            Spacer()
////            cardRemover
//           
//        }.foregroundColor(.red)
//            .font(.largeTitle)
//            .imageScale(.large)
//    }
    //with these vars since they are all 1 line of codes than they do not need the return in the beginning(implicit returning)
    var cards: some View{
        //lazy vgrid uses less space
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0){
            //id:  \.self
            ForEach(viewModel.cards){ card in
                CardView(card, cardColor: Color(viewModel.selectedTheme.cardColor))
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
            //Color is a struct and .blue is a non private static var
        }.onAppear{
            print("Number of cards:", viewModel.cards.count)
        } //.foregroundColor(selectedTheme.cardColor)
    }
    
    
    
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View{
//        Button(action:{
//            cardCount += offset
//        }, label: {
//            Image(systemName: symbol)
//        })
//        //checks the bounds of the emoji array
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
//
//    func cardThemeAdjuster(theme: Array<String>, title: String, symbol: String) -> some View{
//        VStack{
//            Button(action:{
//                emojis = theme
//                emojis.shuffle()
//            }, label:{
//                Image(systemName: symbol)
//            })
//            Text(title).font(.footnote)
//        }
//        
//    }
    
//    var theme1: some View{
//        cardThemeAdjuster(theme: ["🌲", "🌲", "🌵", "🌵", "🌷", "🌷", "🍄", "🍄", "🍁", "🍁"], title: "Theme 1", symbol: "tree.fill")
//    }
//    var theme2: some View{
//        cardThemeAdjuster(theme: ["🐶", "🐶", "🐭", "🐭", "🐰", "🐰", "🐻", "🐻", "🐨", "🐨"], title: "Theme 2", symbol: "tortoise.fill")
//    }
//    var theme3: some View{
//        cardThemeAdjuster(theme: ["🍎", "🍎", "🍕", "🍕", "🍉", "🍉", "🍪", "🍪", "🥑", "🥑"], title: "Theme 3", symbol: "fork.knife")
//    }
    
//    var cardRemover: some View{
//       return cardCountAdjuster(by: -1, symbol: "minus.square.fill")
//    }
//    
//    var cardAdder: some View{
//        return cardCountAdjuster(by: 1, symbol: "plus.square.fill")
//
//    }
//    
}

//Views are immutable
struct CardView: View {
//    @State var isFaceUp: Bool = false
//    let cardFace: String
    let card: MemorizeGameLogic<String>.Card
    let cardColor: Color
    
    init(_ card: MemorizeGameLogic<String>.Card, cardColor: Color) {
        self.card = card
        self.cardColor = cardColor
    }
    
    var body: some View {
           ZStack {
               let base = RoundedRectangle(cornerRadius: 12)
               
               if card.isFaceUp {
                   Group {
                       base.fill().foregroundColor(.white)
                       base.strokeBorder(cardColor, lineWidth: 5)
                       Text(card.content)
                           .font(Font.system(size: 40)) // ✅ Reduce size for visibility
                           .minimumScaleFactor(0.1)
                           .aspectRatio(1, contentMode: .fit)
                   }
               }else{
                   base.fill(cardColor)
                   base.strokeBorder(cardColor, lineWidth: 4)
               }
           }
           .opacity(card.isMatched ? 0 : 1) //hide matched cards
           .onAppear {
               print("Rendering card:", card.content) //Debug print
           }
       }
    }





struct EmojiMemoryView_Previews: PreviewProvider {
    static var previews: some View{
        EmojiMemoryView(viewModel: EmojiMemorizeGame())
    }
}

