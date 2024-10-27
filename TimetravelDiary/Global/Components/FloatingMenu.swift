//
//  FloatingMenu.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/15/24.
//

import SwiftUI

struct FloatingMenu: View {
    
    @State var showDiaryMenu = false
    @State var showMemoMenu = false
    
    @Binding var selectedDate: Date?
    
    var body: some View {
        VStack {
            Spacer()
            if showDiaryMenu, let selectedDate {
                NavigationLink(destination: {
                    WriteDiaryView(seletedDate: CalendarView.dateFormatter.string(from: selectedDate))
                }, label: {
                    MenuItem(icon:"book.fill")
                })
            }
            if showMemoMenu, let selectedDate {
                NavigationLink(destination: {
                    WriteMemoView(selectedDate: CalendarView.dateFormatter.string(from: selectedDate))
                }, label: {
                    MenuItem(icon:"pencil.line")
                })
            }
            
            Button(action: {
                self.showMenu()
            }) {
                ZStack {
                    Circle()
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.green, Color.blue, Color.white]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 4
                        )
                        .shadow(color: Color.blue.opacity(0.8), radius: 10, x: 0, y: 0)
                        .shadow(color: Color.blue.opacity(0.6), radius: 20, x: 0, y: 0)
                        .shadow(color: Color.blue.opacity(0.4), radius: 30, x: 0, y: 0)
                        .frame(width: 50, height: 50)

                    Image(systemName: "star.fill")
                        .imageScale(.large)
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    
    func showMenu() {
        withAnimation(.easeInOut.delay(0.1)) {
            self.showMemoMenu.toggle()
        }
        withAnimation(.easeInOut.delay(0.2)) {
            self.showDiaryMenu.toggle()
//            showFloatingMenu = false // 메뉴가 열릴 때 플로팅 버튼 숨기기
        }
    }
}

struct MenuItem: View {
    
    var icon: String // icon을 받아서 처리하도록 변경
    var body: some View {
        ZStack{
            Circle()
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.green, Color.blue]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ), lineWidth: 4
                )
                .shadow(color: Color.blue.opacity(0.8), radius: 10, x: 0, y: 0)
                .shadow(color: Color.blue.opacity(0.6), radius: 20, x: 0, y: 0)
                .shadow(color: Color.blue.opacity(0.4), radius: 30, x: 0, y: 0)
                .foregroundColor(Color(red:153/255, green:102/255, blue:255/255 ))
                .frame(width:50,height:50)
            Image(systemName: icon)
                .imageScale(.large)
                .foregroundColor(.white)
        }
        .shadow(color: .gray, radius: 0.3, x: 1, y: 1)
        .transition(.move(edge: .trailing))
    }
}
