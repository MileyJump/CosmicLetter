//
//  WirteMemoView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/15/24.
//

import SwiftUI

struct WriteMemoView: View {
    
    @State var text = ""
    
    var body: some View {
        TextField("", text: $text)
            .placeholder(when: text.isEmpty) {
                Text("제목을 입력해주세요")
                    .foregroundColor(.gray)
                    .font(.title)
            }
            .padding()
            .background(Color.clear)
            .foregroundColor(.white)
        
            .gradientBackground(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 0)
    }
    
    
}

#Preview {
    WriteMemoView()
}
