//
//  FlyingNumber.swift
//  MemorizeGame
//
//  Created by Fernando Romo on 3/18/25.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    var body: some View {
        Text(number, format: .number)
    }
}

#Preview {
    FlyingNumber()
}
