//
//  MacOSContentView.swift
//  Conway's Game Of Life (macOS)
//
//  Created by Simon Schöpke on 29.11.20.
//

import SwiftUI

struct MacOSContentView: View {
    let colors = [Color(hex: "22577A"), Color(hex: "38A3A5"), Color(hex: "57CC99"), Color(hex: "80ED99"), Color(hex: "C7F9CC")]
    
    var body: some View {
        GridView()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: colors),
                                       startPoint: .leading,
                                       endPoint: .trailing))
    }
}
