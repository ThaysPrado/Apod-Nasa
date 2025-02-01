//
//  ViewModifier.swift
//  APOD
//
//  Created by Thays Prado on 01/02/25.
//

import SwiftUI

struct NasaAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let message: String
    let actions: [NasaAlert.Action]
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $isPresented) {
                ForEach(actions, id: \.buttonTitle) { action in
                    Button(action.buttonTitle, action: {
                        action.handler?()
                    })
                }
            } message: {
                Text(message)
            }
    }
}
