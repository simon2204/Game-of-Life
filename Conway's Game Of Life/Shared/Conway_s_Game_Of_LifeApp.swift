//
//  Conway_s_Game_Of_LifeApp.swift
//  Shared
//
//  Created by Simon Schöpke on 25.11.20.
//

import SwiftUI

@main
struct Conway_s_Game_Of_LifeApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            MacOSContentView()
            #elseif os(iOS)
            IOSContentView()
            #endif
        }
    }
}
