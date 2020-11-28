//
//  ContentView.swift
//  Shared
//
//  Created by Simon Schöpke on 25.11.20.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let colors = [Color(hex: "22577A"), Color(hex: "38A3A5"), Color(hex: "57CC99"), Color(hex: "80ED99"), Color(hex: "C7F9CC")]
    
    var body: some View {
        GridTouchLocationView(cellSize: CGSize(width: 20, height: 10)) { cell in
            print(cell)
        }
        .foregroundColor(.white)
        .background(LinearGradient(gradient: Gradient(colors: colors),
                                   startPoint: .leading,
                                   endPoint: .trailing))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
