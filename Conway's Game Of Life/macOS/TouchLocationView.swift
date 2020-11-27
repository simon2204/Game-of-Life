//
//  TouchLocationView.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 27.11.20.
//

import SwiftUI
import Cocoa

struct TouchLocationView: NSViewRepresentable {
    var tappedCallback: ((CGPoint) -> Void)

    func makeNSView(context: NSViewRepresentableContext<TouchLocationView>) -> NSView {
        let v = NSView(frame: .zero)
        let gesture = NSClickGestureRecognizer(target: context.coordinator,
                                             action: #selector(Coordinator.tapped))
        v.addGestureRecognizer(gesture)
        return v
    }

    class Coordinator: NSObject {
        var tappedCallback: ((CGPoint) -> Void)
        init(tappedCallback: @escaping ((CGPoint) -> Void)) {
            self.tappedCallback = tappedCallback
        }
        @objc func tapped(gesture: NSClickGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            self.tappedCallback(point)
        }
    }

    func makeCoordinator() -> TouchLocationView.Coordinator {
        return Coordinator(tappedCallback: self.tappedCallback)
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
    }

}
