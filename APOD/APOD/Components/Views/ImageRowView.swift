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
    let thumbnailUrl: String
    let date: String
    let title: String

    var body: some View {
        ZStack(alignment: .bottom) {
            CachedAsyncImage(url: URL(string: thumbnailUrl.isEmpty ? url : thumbnailUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .id("ImageRowView")
            } placeholder: {
                ImageLoaderView()
            }
            
            HStack {
                Text(date)
                Text("-")
                Text(title).id("ImageRowTitleText")
            }
            .font(.helvetica(with: .light, forTextStyle: .callout))
            .padding([.leading, .trailing], NasaSpacing.regular.rawValue)
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
        thumbnailUrl: "",
        date: "2025-02-01",
        title: "Galaxy"
    ).frame(width: 200, height: 200)
}
