//
//  ContentView.swift
//  MemorizeGame
//
//  Created by Fernando Romo on 12/14/24.
//

import SwiftUI

struct ContentView: View {
    //these variables are structs but view is not
//    var i: Int
//    var b: String
    
    
    //to behave like a view you need var body
    //"some View" means look for a view and if you find it return it
    var body: some View {
        let emojis: [String] = ["👻", "🙈", "🤡", "💩", "👻"]

        //H stack stands for horizontal stack, child views are placed side by side.
        HStack {
            ForEach(emojis.indices, id: \.self){ index in
                CardView(cardFace: emojis[index])
            }
//            CardView(cardFace: emojis[0])
//            CardView(cardFace: emojis[1])
//            CardView(cardFace: emojis[2])
//            CardView(cardFace: emojis[3])
        }
        //ZStack is towards the user, basically up and down
        
        //everything below the VStack scope will be applied to everything in the body scope
        .foregroundColor(.blue)
        .padding()
    }
}

//Views are immutable
struct CardView: View {
    @State var isFaceUp: Bool = true
    let cardFace: String
    
    
    var body: some View {
        ZStack{
            //creating a local variable
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            
            //Everything below is basically a function
            //these functions are called view modifiers
            //create another rectangle because it is not possible fill a rectangle and have a outline, in case if a user has dark mode enabled and cannot see the card
            if isFaceUp{
                base.fill()
                    .foregroundColor(.white)
                base
                //strokeBorder creates an outline/trim
                    .strokeBorder(style: StrokeStyle(lineWidth: 5))
                Text(cardFace).font(.largeTitle)
            }else{
                base.fill()
            }
        }//takes a function to execute when someone taps
        .onTapGesture {
            isFaceUp.toggle()
        }
        }
    }




#Preview {
    ContentView()
}

