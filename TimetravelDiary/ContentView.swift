//
//  ContentView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/14/24.
//

import SwiftUI

struct ContentView: View {
    enum Tab {
        case Home, b, setting
    }
    
    @State private var selected: Tab = .Home
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selected) {
                    Group {
                        HomeCalendarView()
                            .tag(Tab.Home)
                        
                        NavigationStack {
                            InfoView()
                        }
                        .tag(Tab.b)
                        
                        NavigationStack {
                            SettingView()
                        }
                        .tag(Tab.setting)
                    }
                    .toolbar(.hidden, for: .tabBar)
                }
                
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
            Button {
                selected = .Home
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                        .shadow(color: selected == .Home ? Color.blue.opacity(0.8) : Color.clear, radius: selected == .Home ? 10 : 0, x: 0, y: 0)
                        .shadow(color: selected == .Home ? Color.blue.opacity(0.6) : Color.clear, radius: selected == .Home ? 20 : 0, x: 0, y: 0)
                        .shadow(color: selected == .Home ? Color.blue.opacity(0.4) : Color.clear, radius: selected == .Home ? 30 : 0, x: 0, y: 0)
                }
            }
            .foregroundStyle(selected == .Home ? Color.blue : Color.white)
            Spacer()
            
            Button {
                selected = .b
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "gauge.with.dots.needle.bottom.0percent")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                        .shadow(color: selected == .b ? Color.blue.opacity(0.8) : Color.clear, radius: selected == .b ? 10 : 0, x: 0, y: 0)
                        .shadow(color: selected == .b ? Color.blue.opacity(0.6) : Color.clear, radius: selected == .b ? 20 : 0, x: 0, y: 0)
                        .shadow(color: selected == .b ? Color.blue.opacity(0.4) : Color.clear, radius: selected == .b ? 30 : 0, x: 0, y: 0)
                }
            }
            .foregroundStyle(selected == .b ? Color.blue : Color.white)
            Spacer()
            
            Button {
                selected = .setting
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "gearshape")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                        .shadow(color: selected == .setting ? Color.blue.opacity(0.8) : Color.clear, radius: selected == .setting ? 10 : 0, x: 0, y: 0)
                        .shadow(color: selected == .setting ? Color.blue.opacity(0.6) : Color.clear, radius: selected == .setting ? 20 : 0, x: 0, y: 0)
                        .shadow(color: selected == .setting ? Color.blue.opacity(0.4) : Color.clear, radius: selected == .setting ? 30 : 0, x: 0, y: 0)
                }
            }
            .foregroundStyle(selected == .setting ? Color.blue : Color.white) // 여기서 수정됨
            
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
}
