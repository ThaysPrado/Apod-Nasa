//
//  FavoriteView.swift
//  APOD
//
//  Created by Thays Prado on 01/02/25.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject private var viewModel: FavoriteViewModel
    @State private var isImageTapped = false
    @State private var askAboutDelete = false
    @State private var showAlertError = false
    @State private var selectedApod: Apod?
    
    init(viewModel: FavoriteViewModel = FavoriteViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.status.isSuccess {
                    if viewModel.apods?.isEmpty ?? true {
                        ErrorView(
                            title: String(localized: "GenericErrorTitle"),
                            message: String(localized: "FavoriteEmptyMessage")
                        ).accessibilityIdentifier("emptyMessage")
                    } else {
                        LazyVStack(alignment: .leading, spacing: 16) {
                            ForEach(viewModel.apods ?? [], id: \.self) { item in
                                ImageRowView(
                                    url: item.url,
                                    thumbnailUrl: item.thumbnailUrl ?? "",
                                    date: item.date,
                                    title: item.title
                                )
                                .cornerRadius(20)
                                .onTapGesture {
                                    selectedApod = item
                                }
                                .accessibilityIdentifier("favoriteItem_\(item.title)")
                            }
                        }
                        .padding()
                        .sheet(item: $selectedApod) { apod in
                            detailView(apod: apod)
                        }
                    }
                }

                if viewModel.status.isFailure {
                    ErrorView(
                        title: String(localized: "GenericErrorTitle"),
                        message: String(localized: "GenericErrorMessage")
                    ).accessibilityIdentifier("errorMessage")
                }

                if viewModel.status.isLoading {
                    ImageLoaderView()
                        .cornerRadius(20)
                        .accessibilityIdentifier("loadingIndicator")
                }

            }
            .navigationTitle(String(localized: "Favorites"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.fetchAll()
        }
        .accessibilityIdentifier("favoriteView")
    }
    
    private func detailView(apod: Apod?) -> some View {
        ScrollView {
            LazyVStack {
                if apod?.isImage() ?? true {
                    ImageView(url: apod?.url ?? "").onTapGesture {
                        isImageTapped.toggle()
                    }
                } else {
                    VideoPlayerView(videoURL: apod?.url ?? "")
                        .frame(height: 250)
                        .padding(.top, 16)
                }
                InformationView(
                    title: apod?.title ?? "",
                    explanation: apod?.explanation ?? "",
                    date: apod?.date ?? "",
                    copyright: apod?.copyright ?? "",
                    url: apod?.url ?? "",
                    isFavorited: true,
                    action: {
                        self.askAboutDelete.toggle()
                    },
                    isSheetPresented: true
                )
            }
            .nasaAlert(
                isPresented: $askAboutDelete,
                title: String(localized: "Warning"),
                message: String(localized: "AreYouSureUnfavorite"),
                actions: [
                    .ok {
                        self.delete(apod?.date ?? "")
                        self.selectedApod = nil
                    },
                    .close
                ]
            )
            .nasaAlert(
                isPresented: $showAlertError,
                title: String(localized: "GenericErrorTitle"),
                message: String(localized: "GenericErrorMessage"),
                actions: [
                    .ok {
                        showAlertError.toggle()
                    }
                ]
            )
        }
    }
    
    private func delete(_ date: String) {
        let wasDelete = viewModel.delete(byDate: date)
        if wasDelete {
            viewModel.fetchAll()
            return
        }
        
        showAlertError.toggle()
    }
}

#Preview {
    FavoriteView()
}
