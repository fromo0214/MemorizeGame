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
        //H stack stands for horizontal stack, child views are placed side by side.
        HStack {
            CardView(isFaceUp: true, cardFace: "👻")
            CardView(cardFace: "🙈")
            CardView(cardFace: "🤡")
            CardView(cardFace: "💩")
        }
        //ZStack is towards the user, basically up and down
        
        //everything below the VStack scope will be applied to everything in the body scope
        .foregroundColor(.blue)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = false
    var cardFace: String
    
    
    var body: some View {
        ZStack(content: {
            
            //Everything below is basically a function
            //these functions are called view modifiers
            //create another rectangle because it is not possible fill a rectangle and have a outline, in case if a user has dark mode enabled and cannot see the card
            if isFaceUp{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                //strokeBorder creates an outline/trim
                    .strokeBorder(style: StrokeStyle(lineWidth: 5))
                Text(cardFace).font(.largeTitle)
            }else{
                RoundedRectangle(cornerRadius: 12)
            }
        })
        }
    }




#Preview {
    ContentView()
}

