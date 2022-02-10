//
//  ContentView.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-03.
//

import SwiftUI

struct MemoryGameView: View {
    
    @ObservedObject var viewModel = MemoryGameViewModel()
        
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.bold)
            memoryGame
        }
    }
    
    var memoryGame: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .padding(5)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
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
//            deck = DeckThemes.themeVehicles.shuffled()
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
            //deck = DeckThemes.themeFood.shuffled()
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
            //deck = DeckThemes.themeAnimals.shuffled()
        } label: {
            VStack {
                Image(systemName: "tortoise")
                Text("Animal")
                    .font(.caption)
            }
        }
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
    let card: MemoryGame<String>.MemoryCard
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack {
            if card.isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .stroke(lineWidth: 3)
                    .foregroundColor(.purple)
                Text(card.content).font(.largeTitle)
            } else {
                shape
                    .fill()
                    .foregroundColor(.purple)
            }
        }
    }
}
