//
//  HomeView.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var isCalendarPresented = false
    @State private var isImageTapped = false
    @State private var showAlertError = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if viewModel.status.isLoading {
                        loadingView
                    }
                    if viewModel.status.isSuccess {
                        successView
                    }
                    if viewModel.status.isFailure {
                        errorView
                    }
                }
                .padding(.top, 20)
            }
            .navigationTitle(String(localized: "APOD"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button(action: {
                    isCalendarPresented.toggle()
                }) {
                    Image(systemName: "calendar")
                        .foregroundColor(.baseCustom)
                }
            )
            .onAppear {
                viewModel.getAPOD()
            }
            .sheet(isPresented: $isCalendarPresented) {
                CalendarView(
                    selectedDate: Binding(
                        get: { viewModel.selectedDate },
                        set: { viewModel.selectedDate = $0 }
                    ),
                    isPresented: $isCalendarPresented
                )
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $isImageTapped) {
                FullImageView(imageURL: viewModel.apod?.url ?? "")
            }
        }
    }
    
    private var loadingView: some View {
        LazyVStack {
            ImageLoaderView()
            InformationLoaderView()
        }
    }
    
    private var successView: some View {
        LazyVStack {
            if viewModel.apod?.isImage() ?? true {
                ImageView(url: viewModel.apod?.url ?? "").onTapGesture {
                    isImageTapped.toggle()
                }
            } else {
                VideoPlayerView(videoURL: viewModel.apod?.url ?? "").frame(height: 250)
            }
            InformationView(
                title: viewModel.apod?.title ?? "",
                explanation: viewModel.apod?.explanation ?? "",
                date: viewModel.apod?.date ?? "",
                copyright: viewModel.apod?.copyright ?? "",
                url: viewModel.apod?.url ?? "",
                isFavorited: viewModel.isFavoried,
                action: {
                    self.save()
                },
                isSheetPresented: false
            )
        }.nasaAlert(
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
    
    private var errorView: some View {
        LazyVStack {
            ErrorView(
                title: String(localized: "GenericErrorTitle"),
                message: viewModel.errorMessage ?? ""
            )
        }
    }
    
    private func save() {
        let isComplete = viewModel.save()
        if !isComplete {
            showAlertError.toggle()
        }
    }
}

#Preview {
    HomeView()
}
