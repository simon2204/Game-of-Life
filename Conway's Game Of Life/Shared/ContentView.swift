//
//  ContentView.swift
//  Shared
//
//  Created by Simon Schöpke on 25.11.20.
//

import SwiftUI

struct ContentView: View {
    init() {
        let sonne = ["0001100000",
                     "0010010000",
                     "0100001000",
                     "1000000100",
                     "1000000100",
                     "0100001000",
                     "0010010000",
                     "0001100000",
                     "0000000000",
                     "0000000000"]
        
        let gameOfLife = GameOfLife(sonne)
        gameOfLife?.startTimer()
    }
    
    var body: some View {
        GeometryReader { geometry -> AnyView in
            let size = geometry.size
            let path = Path { path in
                for x in stride(from: 0, to: size.width, by: 10) {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: size.height))
                }
                
                for y in stride(from: 0, to: size.height, by: 10) {
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: size.width, y: y))
                }
            }
            
            return AnyView(path.stroke(Color.gray, lineWidth: 0.25))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
