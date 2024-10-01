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
//    @State var showMenuItem3 = false
    
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
            if showMemoMenu {
                NavigationLink(destination: {
                    WriteMemoView()
                }, label: {
                    MenuItem(icon:"pencil.line")
                })
                
            }
//            if showMenuItem3 {
//                MenuItem(icon:"square.and.arrow.up.fill")
//            }
            
            
            Button(action: {
                self.showMenu()
            }) {
                ZStack{
                    Circle()
                        .stroke(Color.blue, lineWidth: 4)
                        .shadow(color: Color.blue.opacity(0.8), radius: 10, x: 0, y: 0)
                        .shadow(color: Color.blue.opacity(0.6), radius: 20, x: 0, y: 0)
                        .shadow(color: Color.blue.opacity(0.4), radius: 30, x: 0, y: 0)
                        .foregroundColor(Color(red:153/255, green:102/255, blue:255/255 ))
                        .frame(width:55,height:55)
                    Image(systemName: "star.fill")
                        .imageScale(.large)
                        .foregroundColor(.white)
                    
                    
//                    Circle()
//                        .foregroundColor(Color(red:153/255, green:102/255, blue:255/255 ))
//                        .frame(width:55,height:55)
//                    Image(systemName: "plus.circle.fill")
//                        .resizable()
//                        .frame(width:60,height:60)
//                        .foregroundColor(.white)
//                        .foregroundColor(Color(red:153/255, green:102/255, blue:255/255 ))
//                        .shadow(color: .gray, radius: 0.3, x: 1, y: 1)
////                        .background(Color.black) // 배경을 어둡게 설정해 대비
//                        .cornerRadius(10)
                }
            }
        }
        
    }
    
    
    func showMenu() {
//        withAnimation {
////            self.showMenuItem3.toggle()
//        }
        withAnimation(.easeInOut.delay(0.1)) {
            self.showMemoMenu.toggle()
        }
        withAnimation(.easeInOut.delay(0.2)) {
            self.showDiaryMenu.toggle()
        }
    }
}
//
//struct FloatingMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        FloatingMenu()
//    }
//}

struct MenuItem: View {
    
    var icon: String // icon을 받아서 처리하도록 변경
    var body: some View {
        ZStack{
            Circle()
                .stroke(Color.blue, lineWidth: 4)
                .shadow(color: Color.blue.opacity(0.8), radius: 10, x: 0, y: 0)
                .shadow(color: Color.blue.opacity(0.6), radius: 20, x: 0, y: 0)
                .shadow(color: Color.blue.opacity(0.4), radius: 30, x: 0, y: 0)
                .foregroundColor(Color(red:153/255, green:102/255, blue:255/255 ))
                .frame(width:55,height:55)
            Image(systemName: icon)
                .imageScale(.large)
                .foregroundColor(.white)
        }
        .shadow(color: .gray, radius: 0.3, x: 1, y: 1)
        .transition(.move(edge: .trailing))
    }
}

