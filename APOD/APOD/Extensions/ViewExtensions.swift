//
//  ViewExtension.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//

import SwiftUI

extension View {
    func blinking(duration: Double = 1) -> some View {
        modifier(BlinkViewModifier(duration: duration))
    }
}
