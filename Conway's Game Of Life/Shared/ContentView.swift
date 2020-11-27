//
//  ContentView.swift
//  Shared
//
//  Created by Simon Schöpke on 25.11.20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GridTouchLocationView { cell in
            print(cell)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
