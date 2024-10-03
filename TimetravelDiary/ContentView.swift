//
//  ContentView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/14/24.
//

import SwiftUI

//struct ContentView: View {
//    
//    init() {
//          let appearance = UITabBarAppearance()
//          appearance.configureWithOpaqueBackground()
//          appearance.backgroundColor = UIColor.clear // 탭바 배경색 설정
//          
//          // 선택되지 않은 탭바 아이템 색상 설정
//          UITabBar.appearance().unselectedItemTintColor = UIColor.gray
//          
//          // 탭바 모양 적용
//          UITabBar.appearance().standardAppearance = appearance
//          UITabBar.appearance().scrollEdgeAppearance = appearance
//      }
//    
//    
//    var body: some View {
//        NavigationView {
//            TabView {
//                HomeCalendarView()
//                    .tabItem {
//                        Image(systemName: "calendar")
//                        Text("캘린더")
//                    }
//                
//                InfoView()
//                    .tabItem {
//                        Image(systemName: "note.text")
//                        Text("메모")
//                    }
//              
//                UnreadDiaryView()
//                    .tabItem {
//                        Image(systemName: "star")
//                        Text("일기")
//                    }
//                
//                WriteMemoView()
//                    .tabItem {
//                        Image(systemName: "gearshape")
//                        Text("설정")
//                    }
//                
//            }
//            .accentColor(.black)
//        }
//    }
////            .font(.headline)   //탭 바 텍스트 스타일
////            .accentColor(.white)
////    }
//}
//
//#Preview {
//    ContentView()
//}

struct ContentView: View {
    enum Tab {
        case Home, b, c, setting
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
                        .tag(Tab.c)
                        
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
                        .shadow(color: selected == .Home ? Color.blue.opacity(0.8) : Color.clear, radius: selected == .Home ? 10 : 0, x: 0, y: 0) // 첫 번째 그림자
                        .shadow(color: selected == .Home ? Color.blue.opacity(0.6) : Color.clear, radius: selected == .Home ? 20 : 0, x: 0, y: 0) // 두 번째 그림자
                        .shadow(color: selected == .Home ? Color.blue.opacity(0.4) : Color.clear, radius: selected == .Home ? 30 : 0, x: 0, y: 0) // 세 번째 그림자
                    if selected == .Home {
                        Text("홈")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .Home ? Color.blue : Color.primary)
            Spacer()
            Button {
                selected = .b
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "gauge.with.dots.needle.bottom.0percent")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                        .shadow(color: selected == .b ? Color.blue.opacity(0.8) : Color.clear, radius: selected == .b ? 10 : 0, x: 0, y: 0) // 첫 번째 그림자
                        .shadow(color: selected == .b ? Color.blue.opacity(0.6) : Color.clear, radius: selected == .b ? 20 : 0, x: 0, y: 0) // 두 번째 그림자
                        .shadow(color: selected == .b ? Color.blue.opacity(0.4) : Color.clear, radius: selected == .b ? 30 : 0, x: 0, y: 0) // 세 번째 그림자
                    if selected == .b {
                        Text("홈")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .b ? Color.white : Color.gray)
            Spacer()
            Button {
                selected = .c
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "book.pages")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                        .shadow(color: selected == .c ? Color.blue.opacity(0.8) : Color.clear, radius: selected == .c ? 10 : 0, x: 0, y: 0) // 첫 번째 그림자
                        .shadow(color: selected == .c ? Color.blue.opacity(0.6) : Color.clear, radius: selected == .c ? 20 : 0, x: 0, y: 0) // 두 번째 그림자
                        .shadow(color: selected == .c ? Color.blue.opacity(0.4) : Color.clear, radius: selected == .c ? 30 : 0, x: 0, y: 0) // 세 번째 그림자
                    if selected == .c {
                        Text("추억확인")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .c ? Color.accentColor : Color.gray)
            Spacer()
            Button {
                selected = .setting
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "gearshape")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                        .shadow(color: selected == .setting ? Color.blue.opacity(0.8) : Color.clear, radius: selected == .setting ? 10 : 0, x: 0, y: 0) // 첫 번째 그림자
                        .shadow(color: selected == .setting ? Color.blue.opacity(0.6) : Color.clear, radius: selected == .setting ? 20 : 0, x: 0, y: 0) // 두 번째 그림자
                        .shadow(color: selected == .setting ? Color.blue.opacity(0.4) : Color.clear, radius: selected == .setting ? 30 : 0, x: 0, y: 0) // 세 번째 그림자
                    if selected == .setting {
                        Text("설정")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .setting ? Color.accentColor : Color.primary)
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

struct BView: View {
    var body: some View {
        Text("View B")
    }
}



#Preview {
    ContentView()
}
