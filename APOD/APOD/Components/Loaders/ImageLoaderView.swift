//
//  ImageLoaderView.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//

import SwiftUI

struct ImageLoaderView: View {
    let firstColor: Color = Color(.gray).opacity(0.3)
    let secondColor: Color = Color(.gray).opacity(0.2)

    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [firstColor, secondColor, firstColor]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(height: 200)
            .shimmering()
    }
}

#Preview {
    ImageLoaderView()
}
