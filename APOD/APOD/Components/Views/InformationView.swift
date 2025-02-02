//
//  InformationView.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//

import SwiftUI

struct InformationView: View {
    @State private var showShareSheet = false
    
    let title: String
    let explanation: String
    let date: String
    let copyright: String?
    let url: String
    @State var isFavorited: Bool
    var action: () -> Void
    let isSheetPresented: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: NasaSpacing.regular.rawValue) {
            if let copyright = copyright {
                Text(copyright.removeBreakLines())
                    .font(.helvetica(with: .light, forTextStyle: .callout))
            }
            HStack {
                Text(date)
                    .font(.helvetica(with: .light, forTextStyle: .callout))
                Spacer()
                HStack {
                    Button(action: {
                        showShareSheet.toggle()
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.blue)
                        }.padding(.trailing, 10)
                    Button(action: {
                            action()
                            if !isSheetPresented {
                                isFavorited.toggle()
                            }
                        }) {
                            Image(systemName: isFavorited ?  "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            
            Text(title)
                .font(.helvetica(with: .bold, forTextStyle: .title3))

            Text(explanation)
                .font(.helvetica(with: .regular, forTextStyle: .body))
                .multilineTextAlignment(.leading)
        }
        .padding()
        .foregroundColor(.gray)
        .sheet(isPresented: $showShareSheet) {
            ActivityViewController(activityItems: [url])
        }
    }
}

#Preview {
    InformationView(title: "Galaxy",
                    explanation: "Lorem ipsum",
                    date: "2025-01-30",
                    copyright: "Nasa Lorem ipsum",
                    url: "http://",
                    isFavorited: false,
                    action: {
                        print("Click")
                    },
                    isSheetPresented: false)
}
