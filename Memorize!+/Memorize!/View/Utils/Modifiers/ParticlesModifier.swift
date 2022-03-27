//
//  ParticlesModifier.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-03-27.
//

import SwiftUI

struct ParticlesModifier: ViewModifier {
    @State var time = 0.0
    @State var scale = 0.1
    var delay = 0.0
    let duration = 3.0
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<80, id: \.self) { index in
                content
                    .hueRotation(Angle(degrees: time * 80))
                    .scaleEffect(scale)
                    .modifier(FireworkParticlesGeometryEffect(time: time))
                    .opacity(((duration-time) / duration))
            }
        }
        .onAppear {
            withAnimation (.easeOut(duration: duration).delay(delay).repeatForever(autoreverses: false)) {
                self.time = duration
                self.scale = 1.0
            }
        }
    }
}
