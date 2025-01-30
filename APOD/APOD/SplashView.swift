//
//  SplashView.swift
//  Apod-Nasa
//
//  Created by Thays Prado on 29/01/25.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                Rectangle().background(Color.red)
            } else {
                Image("LaunchLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
#Preview {
    SplashView()
}
