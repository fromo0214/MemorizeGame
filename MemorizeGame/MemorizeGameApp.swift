//
//  MemorizeGameApp.swift
//  MemorizeGame
//
//  Created by Fernando Romo on 12/14/24.
//
//Main()
import SwiftUI

@main
struct MemorizeGameApp: App {
    @StateObject var game = EmojiMemorizeGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryView(viewModel: game)
        }
    }
}
