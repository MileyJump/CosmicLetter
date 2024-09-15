//
//  TabBarView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/13/24.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
//            HomeView()
            PricaticContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .accentColor(.blue) // 탭바 선택 색상 변경
    }
}

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Home View")
                .font(.largeTitle)
        }
    }
}

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings View")
                .font(.largeTitle)
        }
    }
}

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profile View")
                .font(.largeTitle)
        }
    }
}

//@main
//struct TabBarApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
