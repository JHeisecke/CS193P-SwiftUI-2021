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
                NavigationLink(
                    destination:
                        MemoryGameView(
                            viewModel: MemoryGameViewModel()
                        )
                ) {
                    Text("Emojis")
                }
            }
            .navigationBarTitle("Memorize!")
            .navigationBarItems(
                leading:
                    Button(
                        action: {
                            
                        })
                {
                    Image(systemName: "plus")
                        .frame(width: 50, height: 50)
                },
                trailing: EditButton().frame(width: 50, height: 50)
            )
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
