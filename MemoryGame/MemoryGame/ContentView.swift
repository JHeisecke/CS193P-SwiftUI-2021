//
//  ContentView.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-03.
//

import SwiftUI

struct ContentView: View {
    
    let emojis = ["🧋", "🥤", "🍰", "🐒", "🚙", "🎧", "🚎", "🍿", "🤖", "👾", "👽", "💀", "☠️", "🦿", "🦵🏻"]
    @State var amountOfCards: Int = 4
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(emojis[0..<amountOfCards], id: \.self) { emoji in
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
            if amountOfCards < emojis.count {
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
