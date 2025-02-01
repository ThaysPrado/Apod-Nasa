//
//  ImageRowView.swift
//  APOD
//
//  Created by Thays Prado on 01/02/25.
//

import SwiftUI
import CachedAsyncImage

struct ImageRowView: View {
    let url: String
    let date: String
    let title: String

    var body: some View {
        ZStack(alignment: .bottom) {
            CachedAsyncImage(url: URL(string: url)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                ImageLoaderView()
            }
            
            HStack {
                Text(date)
                Text("-")
                Text(title)
            }
            .font(.helvetica(with: .light, forTextStyle: .callout))
            .padding([.leading, .trailing], 8)
            .foregroundColor(.white)
            .lineLimit(1)
            .truncationMode(.tail)
            .background(Color.black.opacity(0.3))
        }
    }
}

#Preview {
    ImageRowView(
        url: "https://apod.nasa.gov/apod/image/2501/M33_1024.jpg",
        date: "2025-02-01",
        title: "Galaxy"
    ).frame(width: 200, height: 200)
}
