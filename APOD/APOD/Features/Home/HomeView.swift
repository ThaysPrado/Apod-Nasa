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
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if let apod = viewModel.apod {
                        ImageView(url: apod.url)
                        InformationView(title: apod.title,
                                        explanation: apod.explanation,
                                        date: apod.date,
                                        copyright: apod.copyright)
                    } else if let errorMessage = viewModel.errorMessage {
                        ErrorView(title: "Warning", message: errorMessage)
                    } else {
                        ImageLoaderView()
                        InformationLoaderView()
                    }
                }.padding(.top, 20)
            }
            .navigationTitle("APOD")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button(action: {
                    isCalendarPresented.toggle()
                }) {
                    Image(systemName: "calendar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            )
            .onAppear {
                viewModel.getAPOD()
            }
            
            if isCalendarPresented {
                CalendarView(selectedDate: $selectedDate, isPresented: $isCalendarPresented)
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

// TODO: need center
struct CalendarView: View {
    @Binding var selectedDate: Date
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("Escolha uma data")
                .font(.headline).padding()
            
            // Picker de data
            DatePicker(
                "",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}

#Preview {
    HomeView()
}
