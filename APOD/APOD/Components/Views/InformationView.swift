//
//  InformationView.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//

import SwiftUI

struct InformationView: View {
    let title: String
    let explanation: String
    let date: String
    let copyright: String?

    var body: some View {
        VStack(alignment: .leading, spacing: NasaSpacing.regular.rawValue) {
            Text(title)
                .font(.helvetica(with: .bold, forTextStyle: .title3))
            
            HStack {
                if let copyright = copyright {
                    Text(copyright)
                        .font(.helvetica(with: .light, forTextStyle: .callout))
                    Text("-")
                }
                Text(date)
                    .font(.helvetica(with: .light, forTextStyle: .callout))
            }
            Text(explanation)
                .font(.helvetica(with: .regular, forTextStyle: .body))
                .multilineTextAlignment(.leading)
        }.padding()
    }
}

#Preview {
    InformationView(title: "Testando",
                    explanation: "Esta é uma descrição longa que pode ser exibida aqui.",
                    date: "30 de janeiro de 2025",
                    copyright: "Nasa")
}
