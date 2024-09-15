//
//  ContentView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/14/24.
//

import SwiftUI

struct ContentView: View {
    enum Tab {
        case Home, b, c
    }
    
    @State private var selected: Tab = .Home
    
    var body: some View {
        ZStack {
            TabView(selection: $selected) {
                Group {
                    NavigationStack {
                        HomeCalendarView()
                    }
                    .tag(Tab.Home)
                    
                    NavigationStack {
                        PricaticContentView()
                    }
                    .tag(Tab.b)
                    
                    NavigationStack {
                        CView()
                    }
                    .tag(Tab.c)
                }
                .toolbar(.hidden, for: .tabBar)
            }
            
            VStack {
                Spacer()
                tabBar
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
                    if selected == .Home {
                        Text("홈")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .Home ? Color.white : Color.primary)
            Spacer()
            Button {
                selected = .b
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "gauge.with.dots.needle.bottom.0percent")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .b {
                        Text("홈")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .b ? Color.white : Color.primary)
            Spacer()
            Button {
                selected = .c
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "book.pages")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .c {
                        Text("추억확인")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .c ? Color.accentColor : Color.primary)
            Spacer()
        }
        .padding()
        .frame(height: 72)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white.opacity(0.2))
                .shadow(color: .black.opacity(0.15), radius: 8, y: 2)
        }
        .padding(.horizontal)
    }
}

struct BView: View {
    var body: some View {
        Text("View B")
    }
}

struct CView: View {
    var body: some View {
        Text("View C")
    }
}

#Preview {
    ContentView()
}
