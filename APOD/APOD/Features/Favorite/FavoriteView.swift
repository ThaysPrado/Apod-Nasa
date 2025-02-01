//
//  FavoriteView.swift
//  APOD
//
//  Created by Thays Prado on 01/02/25.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteViewModel()
    @State private var isImageTapped = false
    @State private var askAboutDelete = false
    @State private var showAlertError = false
    @State private var apodToDelete: Apod?

    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.status.isSuccess {
                    if viewModel.apods?.isEmpty ?? true {
                        ErrorView(
                            title: String(localized: "GenericErrorTitle"),
                            message: String(localized: "FavoriteEmptyMessage")
                        )
                    } else {
                        LazyVStack(alignment: .leading, spacing: 16) {
                            ForEach(viewModel.apods!, id: \.self) { item in
                                ImageRowView(
                                    url: item.url,
                                    date: item.date,
                                    title: item.title
                                )
                                .cornerRadius(20)
                                .onTapGesture {
                                    isImageTapped.toggle()
                                }
                                .sheet(isPresented: $isImageTapped) {
                                    successView(apod: item)
                                }

                            }
                        }
                        .padding()
                        .nasaAlert(
                            isPresented: $askAboutDelete,
                            title: "Aviso",
                            message: "Isso é um alerta",
                            actions: [
                                .ok {
                                    self.delete(apodToDelete?.date ?? "")
                                },
                                .close
                            ]
                        )
                    }
                }

                if viewModel.status.isFailure {
                    ErrorView(
                        title: String(localized: "GenericErrorTitle"),
                        message: String(localized: "GenericErrorMessage")
                    )
                }

                if viewModel.status.isLoading {
                    ImageLoaderView().cornerRadius(20)
                }

            }
            .navigationTitle(String(localized: "Favorites"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.fetchAll()
        }
    }
    
    private func successView(apod: Apod?) -> some View {
        LazyVStack {
            ImageView(url: apod?.url ?? "")
            InformationView(
                title: apod?.title ?? "",
                explanation: apod?.explanation ?? "",
                date: apod?.date ?? "",
                copyright: apod?.copyright ?? "",
                url: apod?.url ?? "",
                isFavorited: true,
                action: {
                    self.apodToDelete = apod
                    self.askAboutDelete.toggle()
                },
                isSheetPresented: true
            )
        }.nasaAlert(
            isPresented: $askAboutDelete,
            title: String(localized: "Warning"),
            message: String(localized: "AreYouSureUnfavorite"),
            actions: [
                .ok {
                    self.delete(apodToDelete?.date ?? "")
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
