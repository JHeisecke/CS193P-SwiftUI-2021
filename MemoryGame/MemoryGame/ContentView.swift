//
//  ContentView.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-03.
//

import SwiftUI

struct ContentView: View {
    
    let themeVehicles = ["🚙", "🚎", "🚗", "🚕", "🚌", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻"]
    let themeAnimals = ["🐒", "🦅", "🦫", "🦥", "🐿", "🦔", "🦤", "🦁", "🐯"]
    let themeFood = ["🧋", "🥤", "🍰", "🐒", "🍿", "🍖", "🍗", "🥩", "🍔", "🍟", "🍕"]
    
    @State var deck: [String] = []
    @State var amountOfCards: Int = 0
    
    var body: some View {
        if deck.isEmpty {
            VStack {
                Button {
                    deck = themeVehicles
                } label: {
                    Text("Vehicles")
                        .padding()
                        .frame(width: 200, height: 56)
                        
                }
                Button {
                    deck = themeAnimals
                } label: {
                    Text("Animals")
                }
                Button {
                    deck = themeFood
                } label: {
                    Text("Food")
                }
            }
        } else {
            memoryGame
        }
    }
    
    var memoryGame: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(deck[0..<amountOfCards], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                            .padding(5)
                    }
                }
            }
            Spacer()
            HStack {
                plusButton
                Spacer()
                minusButton
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var plusButton: some View {
        Button {
            if amountOfCards < deck.count {
                amountOfCards += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }

    var minusButton: some View {
        Button {
            if amountOfCards > 0 {
                amountOfCards -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

struct CardView: View {
    var content: String
    @State var isFlipped: Bool = true
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack {
            if isFlipped {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .stroke(lineWidth: 3)
                    .foregroundColor(.purple)
                Text(content).font(.largeTitle)
            } else {
                shape
                    .fill()
                    .foregroundColor(.purple)
            }
        }
        .onTapGesture {
            isFlipped = !isFlipped
        }
    }
}
