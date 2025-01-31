//
//  ErrorView.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//

import SwiftUI

struct ErrorView: View {
    let title: String
    let message: String

    var body: some View {
        VStack {
            Text(title)
                .font(.helvetica(with: .bold, forTextStyle: .title3))
            Text(message)
                .font(.helvetica(with: .bold, forTextStyle: .title3))
        }.padding()
    }
}

#Preview {
    ErrorView(title: "Houston, we have a problem", message: "message")
}
