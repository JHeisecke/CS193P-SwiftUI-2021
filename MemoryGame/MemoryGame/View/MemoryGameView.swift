//
//  ContentView.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-03.
//

import SwiftUI

struct MemoryGameView: View {
    
    @State var deck: [String] = []
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.bold)
            if deck.isEmpty {
                ThemeButton(deck: $deck, theme: DeckThemes.themeVehicles, text: "Vehicles")
                ThemeButton(deck: $deck, theme: DeckThemes.themeAnimals, text: "Animals")
                    .padding(.vertical)
                ThemeButton(deck: $deck, theme: DeckThemes.themeFood, text: "Foods")
            } else {
                memoryGame
            }
        }
    }
    
    var memoryGame: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(deck, id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                            .padding(5)
                    }
                }
            }
            Spacer()
            HStack {
                vehicleTheme
                Spacer()
                foodTheme
                Spacer()
                animalTheme
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var vehicleTheme: some View {
        Button {
            deck = DeckThemes.themeVehicles.shuffled()
        } label: {
            VStack {
                Image(systemName: "car")
                Text("Vehicles")
                    .font(.caption)
            }
        }
    }
    var foodTheme: some View {
        Button {
            deck = DeckThemes.themeFood.shuffled()
        } label: {
            VStack {
                Image(systemName: "fork.knife")
                Text("Food")
                    .font(.caption)
            }
        }
    }
    var animalTheme: some View {
        Button {
            deck = DeckThemes.themeAnimals.shuffled()
        } label: {
            VStack {
                Image(systemName: "tortoise")
                Text("Animal")
                    .font(.caption)
            }        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameView()
            .previewDevice("iPhone 13 Pro Max")
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

struct ThemeButton: View {
    @Binding var deck: [String]
    var theme: [String]
    var text: String
    
    var body: some View {
        Button {
            deck = theme
        } label: {
            Text(text)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: 100, height: 50, alignment: .center)
                .padding()
                .padding(.horizontal, 20)
                .background(
                    Color.blue
                        .cornerRadius(10)
                        .shadow(radius:10)
                )
        }
    }
}
