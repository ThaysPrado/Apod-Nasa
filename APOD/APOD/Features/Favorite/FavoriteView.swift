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
                        }.padding()
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
                    // TODO: Questionar desfavoritar
                    self.delete(apod?.date ?? "")
                }
            )
        }
    }
    
    private func delete(_ date: String) {
        viewModel.delete(byDate: date)
        viewModel.fetchAll()
    }
}

#Preview {
    FavoriteView()
}
