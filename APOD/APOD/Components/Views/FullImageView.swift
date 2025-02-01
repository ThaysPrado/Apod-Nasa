//
//  FullImageView.swift
//  APOD
//
//  Created by Thays Prado on 01/02/25.
//

import SwiftUI
import CachedAsyncImage

struct FullImageView: View {
    let imageURL: String
    
    @GestureState var draggingOffSet: CGSize = .zero

    var body: some View {
        CachedAsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                ImageLoaderView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .zoomable(
                        minZoomScale: 1,
                        doubleTapZoomScale: 2
                    )
            case .failure:
                ErrorView(
                    title: String(localized: "GenericErrorMessage"),
                    message: String(localized: "ImageNotFoundMessage")
                )
            @unknown default:
                EmptyView()
            }
        }
        .padding()
        .edgesIgnoringSafeArea(.all)
        .gesture(
            DragGesture().updating(
                $draggingOffSet,
                body: { (value, outValue, _) in
                    outValue = value.translation
                }
            )
        )
    }
}
