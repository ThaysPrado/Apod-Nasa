//
//  InformationLoaderView.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//

import SwiftUI

struct InformationLoaderView: View {
    let firstColor: Color = Color(.gray).opacity(0.3)
    let secondColor: Color = Color(.gray).opacity(0.1)
    
    var body: some View {
        VStack(alignment: .leading, spacing: NasaSpacing.regular.rawValue) {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [firstColor, secondColor, firstColor]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: NasaSize.ref60.rawValue)
                .shimmering()
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [firstColor, secondColor, firstColor]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: NasaSize.ref40.rawValue)
                .shimmering()
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [firstColor, secondColor, firstColor]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: NasaSize.ref200.rawValue)
                .shimmering()
        }
        .padding()
    }
}

#Preview {
    InformationLoaderView()
}
