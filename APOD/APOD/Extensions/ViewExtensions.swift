//
//  ViewExtension.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//

import SwiftUI

public extension View {
    /// - Parameters:
    ///   - active: Convenience parameter to conditionally enable the effect.
    ///   - animation: A custom animation.
    ///   - gradient: A custom gradient.
    ///   - bandSize: The size of the animated mask's "band".
    @ViewBuilder func shimmering(
        active: Bool = true,
        animation: Animation = Shimmer.defaultAnimation,
        gradient: Gradient = Shimmer.defaultGradient,
        bandSize: CGFloat = 0.3,
        mode: Shimmer.Mode = .mask
    ) -> some View {
        if active {
            modifier(Shimmer(animation: animation, gradient: gradient, bandSize: bandSize, mode: mode))
        } else {
            self
        }
    }
}

extension View {
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to
    ///     present the alert. When the user presses or taps one of the alert's
    ///     actions, the system sets this value to `false` and dismisses.
    ///   - title: Title to show
    ///   - message: Message to show
    ///   - actions: Actions buttons (cancel, ok, close, etc)
    func nasaAlert(
        isPresented: Binding<Bool>,
        title: String,
        message: String,
        actions: [NasaAlert.Action] = [.ok(handler: nil)]
    ) -> some View {
        self.modifier(
            NasaAlertModifier(
                isPresented: isPresented,
                title: title,
                message: message,
                actions: actions
            )
        )
    }
}
