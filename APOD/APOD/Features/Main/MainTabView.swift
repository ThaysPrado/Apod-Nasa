//
//  MainTableView.swift
//  APOD
//
//  Created by Thays Prado on 01/02/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        ZStack {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text(String(localized: "Home"))
                    }

                FavoriteView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text(String(localized: "Favorites"))
                    }
            }
        }
    }
}
