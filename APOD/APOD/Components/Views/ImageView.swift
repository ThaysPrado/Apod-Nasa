//
//  ImageView.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//

import SwiftUI
import CachedAsyncImage

struct ImageView: View {
    let url: String

    var body: some View {
        CachedAsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFill()
                .id("ImageView")
        } placeholder: {
            ImageLoaderView()
        }
    }
}

#Preview {
    ImageView(url: "https://apod.nasa.gov/apod/image/2501/M33_1024.jpg")
}
