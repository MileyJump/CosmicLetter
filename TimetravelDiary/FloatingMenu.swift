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
     @State var showMenuItem3 = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                if showDiaryMenu {
                    NavigationLink(destination: {
                        WriteDiaryView()
                    }, label: {
                        MenuItem(icon:"book.fill")
                    })
                }
                if showMemoMenu {
                    MenuItem(icon:"pencil.line")
                }
                if showMenuItem3 {
                    MenuItem(icon:"square.and.arrow.up.fill")
                }
                
                
                Button(action: {
                    self.showMenu()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width:80,height:80)
                        .foregroundColor(Color(red:153/255, green:102/255, blue:255/255 ))
                        .shadow(color: .gray, radius: 0.3, x: 1, y: 1)
                }
            }
        }
    }
    
    func showMenu(){
        withAnimation{
                showMenuItem3.toggle()
        }
        
        withAnimation{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    self.showMemoMenu.toggle()
                }

        }
        withAnimation{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            self.showDiaryMenu.toggle()
        }
        
            
        }
        
    }
}

struct FloatingMenu_Previews: PreviewProvider {
    static var previews: some View {
        FloatingMenu()
    }
}

struct MenuItem: View {
    
    var icon: String // icon을 받아서 처리하도록 변경
    var body: some View {
        ZStack{
            Circle()
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

