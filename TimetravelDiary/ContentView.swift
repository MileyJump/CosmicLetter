//
//  ContentView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/14/24.
//

import SwiftUI

struct ContentView: View {
    enum Tab {
        case Home, collection,  read, setting
    }
    
    @State private var selected: Tab = .Home
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selected) {
                    HomeCalendarView()
                        .tag(Tab.Home)
                    
                    NavigationStack {
                        InfoView()
                    }
                    .tag(Tab.collection)
                    
                    NavigationStack {
                        ReadView()
                    }
                    .tag(Tab.read)
                    
                    NavigationStack {
                        SettingView()
                    }
                    .tag(Tab.setting)
                }
                .toolbar(.hidden, for: .tabBar)
                
                VStack {
                    Spacer()
                    tabBar
                }
            }
        }
    }
    
    var tabBar: some View {
        HStack {
            Spacer()
            tabBarButton(imageName: "calendar", tab: .Home, selectedTab: $selected, shadowColor: Diary.color.timeTravelGreenColor)
            Spacer()
            tabBarButton(imageName: "gauge.with.dots.needle.bottom.0percent", tab: .collection, selectedTab: $selected, shadowColor: Color.blue)
            Spacer()
            tabBarButton(imageName: "envelope.open.fill", tab: .read, selectedTab: $selected, shadowColor: Color.green)
            Spacer()
            tabBarButton(imageName: "gearshape", tab: .setting, selectedTab: $selected, shadowColor: Color.green)
            Spacer()
        }
        .padding()
        .frame(height: 72)
        .background {
            Capsule()
                .fill(Color.black.opacity(0.4))
                .shadow(color: .black.opacity(0.15), radius: 8, y: 2)
        }
        .padding(.horizontal)
    }
    
    func tabBarButton(imageName: String, tab: Tab, selectedTab: Binding<Tab>, shadowColor: Color) -> some View {
        Button {
            selectedTab.wrappedValue = tab
        } label: {
            VStack(alignment: .center) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22)
                    .shadow(color: selectedTab.wrappedValue == tab ? shadowColor.opacity(0.8) : Color.clear, radius: selectedTab.wrappedValue == tab ? 10 : 0)
                    .shadow(color: selectedTab.wrappedValue == tab ? shadowColor.opacity(0.6) : Color.clear, radius: selectedTab.wrappedValue == tab ? 20 : 0)
                    .shadow(color: selectedTab.wrappedValue == tab ? shadowColor.opacity(0.4) : Color.clear, radius: selectedTab.wrappedValue == tab ? 30 : 0)
            }
        }
        .foregroundStyle(selectedTab.wrappedValue == tab ? shadowColor : Color.white)
    }
}
