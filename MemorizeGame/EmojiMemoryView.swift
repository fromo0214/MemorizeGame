//
//  ContentView.swift
//  MemorizeGame
//
//  Created by Fernando Romo on 12/14/24.
//

import SwiftUI

struct EmojiMemoryView: View {
    //these variables are structs but view is not
//    var i: Int
//    var b: String
    var viewModel: EmojiMemorizeGame
    
    let emojis: [String] = ["🐶", "🐶", "🐭", "🐭", "🐰", "🐰", "🐻", "🐻", "🐨", "🐨"]
//    @State var cardCount : Int = 5
    
    //to behave like a view you need var body
    //"some View" means look for a view and if you find it return it
    var body: some View {

        //Vstack stands for vertical stack
//            Text("Memorize!").font(.largeTitle)
            ScrollView{
                cards
//            Spacer()
//            cardCountAdjusters
           
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]){
            ForEach(emojis.indices, id: \.self){ index in
                CardView(cardFace: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            //Color is a struct and .blue is a non private static var
        }.foregroundColor(Color.blue)
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
    @State var isFaceUp: Bool = false
    let cardFace: String
    
    
    var body: some View {
        ZStack{
            //creating a local variable
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            
            //Everything below is basically a function
            //these functions are called view modifiers
            //create another rectangle because it is not possible fill a rectangle and have a outline, in case if a user has dark mode enabled and cannot see the card
            Group{
                base.fill()
                    .foregroundColor(.white)
                base
                //strokeBorder creates an outline/trim
                    .strokeBorder(style: StrokeStyle(lineWidth: 5))
                Text(cardFace).font(Font.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }//takes a function to execute when someone taps
        .onTapGesture {
            isFaceUp.toggle()
        }
        }
    }





#Preview {
    EmojiMemoryView()
}

