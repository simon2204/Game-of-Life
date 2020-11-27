//
//  TouchLocationView.swift
//  Conway's Game Of Life
//
//  Created by Simon Schöpke on 27.11.20.
//

import SwiftUI
import Cocoa

struct NSTouchLocationView: NSViewRepresentable {
    var tappedCallback: ((CGPoint) -> Void)

    func makeNSView(context: NSViewRepresentableContext<NSTouchLocationView>) -> NSView {
        let view = NSView(frame: .zero)
        let gesture = NSClickGestureRecognizer(target: context.coordinator,
                                             action: #selector(Coordinator.tapped))
        view.addGestureRecognizer(gesture)
        return view
    }

    class Coordinator: NSObject {
        var tappedCallback: ((CGPoint) -> Void)
        
        init(tappedCallback: @escaping ((CGPoint) -> Void)) {
            self.tappedCallback = tappedCallback
        }
        
        @objc func tapped(gesture: NSClickGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            var transform = CGAffineTransform(scaleX: 1, y: -1)
            transform = transform.translatedBy(x: 0, y: -(gesture.view?.bounds.size.height ?? 0))
            let newPointForUIKit = point.applying(transform)
            self.tappedCallback(newPointForUIKit)
        }
    }

    func makeCoordinator() -> NSTouchLocationView.Coordinator {
        return Coordinator(tappedCallback: self.tappedCallback)
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
    }

}
