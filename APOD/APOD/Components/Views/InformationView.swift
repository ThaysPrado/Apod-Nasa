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
        }
        .padding()
        .foregroundColor(.gray)
    }
}

#Preview {
    InformationView(title: "Galaxy",
                    explanation: "Lorem ipsum",
                    date: "2025-01-30",
                    copyright: "Nasa")
}
