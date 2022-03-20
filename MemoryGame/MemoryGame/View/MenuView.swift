//
//  MenuView.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-03-19.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(DeckThemes.allOptions, id: \.self) { theme in
                    NavigationLink(destination:
                                    MemoryGameView(viewModel: MemoryGameViewModel(theme: theme)))
                    {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(theme.name)
                                .font(.headline)
                                .foregroundColor(Color(hex: theme.color))
                            Text(theme.deck.map({$0}).joined(separator: ""))
                                .font(.caption)
                        }
                    }
                }
            }
            .navigationBarTitle("Memorize!")
// TODO: Replace Enum and add functionality for Edit and Add Themes Button
//            .navigationBarItems(
//                leading:
//                    Button(action: { }) {
//                        Image(systemName: "plus")
//                            .frame(width: 50, height: 50)
//                    },
//                trailing: EditButton().frame(width: 50, height: 50)
//            )
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
