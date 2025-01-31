//
//  BlinkingViewModifier.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//

import SwiftUI

struct BlinkViewModifier: ViewModifier {
    let duration: Double
    @State private var blinking: Bool = false

    func body(content: Content) -> some View {
        content
            .opacity(blinking ? 0.3 : 1)
            .animation(.easeInOut(duration: duration).repeatForever(), value: blinking)
            .onAppear {
                blinking.toggle()
            }
    }
}
